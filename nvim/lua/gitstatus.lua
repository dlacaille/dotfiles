local Job = require 'plenary.job'
local Utils = require 'utils'

local timer = nil -- Instance of the timer
local job = nil -- Instance of the job
local running = false -- Timer is running
local ready = true -- Ready to start a new job
local err = false -- Error occurred during fetch

local M = {}

M.up = nil
M.dn = nil

local function tick()
    if not running then
        return nil
    end
    if not ready then
        return nil
    end
    ready = false
    job = Job:new {
        command = 'git',
        args = { 'status', '-sb' },
        on_exit = function(j, return_val)
            if not running then
                return
            end
            local res = table.concat(j:result(), ' ')
            if return_val == 0 then
                err = false
                M.up = tonumber(string.gmatch(res, 'ahead (%d+)')() or '0')
                M.dn = tonumber(string.gmatch(res, 'behind (%d+)')() or '0')
            else
                err = res
            end
            ready = true
        end,
    }
    job:start()
end

local default_opts = {
    delay = 2000,
    interval = 10000,
}

function M.render()
    if not running then
        return nil
    elseif err then
        return err
    else
        local status = {}
        if M.up > 0 then
            table.insert(status, ' ' .. M.up)
        end
        if M.dn > 0 then
            table.insert(status, ' ' .. M.dn)
        end
        return table.concat(status, ' ')
    end
end

function M.setup(opt)
    local merged_opts = {}
    Utils.table_merge(merged_opts, default_opts)
    Utils.table_merge(merged_opts, opt or {})

    running = true
    timer = vim.loop.new_timer()
    timer:start(merged_opts.delay, merged_opts.interval, vim.schedule_wrap(tick))
end

function M.stop()
    running = false
    timer:stop()
end

return M
