---@type LazySpec
return {
  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        win = {
          width = 0, -- 0 means full width
          height = 0, -- 0 means full height
        },
      },
      dashboard = {
        preset = {
          header = table.concat({
            "             .,-:;//;:=,                ",
            "         . :H@@@MM@M#H/.,+%;,           ",
            "      ,/X+ +M@@M@MM%=,-%HMMM@X/,        ",
            "     -+@MM; $M@@MH+-,;XMMMM@MMMM@+-     ",
            "    ;@M@@M- XM@X;. -+XXXXXHHH@M@M#@/.   ",
            "  ,%MM@@MH ,@%=            .---=-=:=,.  ",
            "  -@#@@@MX .,              -%HX$$%%%+;  ",
            " =-./@M@M$                  .;@MMMM@MM: ",
            " X@/ -$MM/                    .+MM@@@M$ ",
            ",@M@H: :@:                    . -X#@@@@-",
            ",@@@MMX, .                    /H- ;@M@M=",
            ".H@@@@M@+,                    %MM+..%#$.",
            " /MMMM@MMH/.                  XM@MH; -; ",
            "  /%+%$XHH@$=              , .H@@@@MX,  ",
            "   .=--------.           -%H.,@@@@@MX,  ",
            "   .%MM@@@HHHXX$$$%+- .:$MMX -M@@MM%.   ",
            "     =XMMM@MM@MM#H;,-+HMM@M+ /MMMX=     ",
            "       =%@M@M#@$-.=$@MM@@@M; %M%=       ",
            "         ,:+$+-,/H#MMMMMMM@- -,         ",
            "               =++%%%%+/:-.             ",
          }, "\n"),
        },
      },
    },
  },
}
