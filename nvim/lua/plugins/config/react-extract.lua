require('react-extract').setup {
    ts_type_property_template = '[INDENT][PROPERTY]: any;\n',
    ts_template_before = 'interface [COMPONENT_NAME]Props {\n[TYPE_PROPERTIES]}\n[EMPTY_LINE]\n'
        .. 'export default function [COMPONENT_NAME]([PROPERTIES]) {\n'
        .. '[INDENT]return (\n',
    ts_template_after = '[INDENT])\n}',
    js_template_before = 'export default function [COMPONENT_NAME]([PROPERTIES]) {\n' .. '[INDENT]return (\n',
    js_template_after = '[INDENT])\n}',
    jsx_indent_level = 2,
    use_class_props = false,
    use_autoimport = true,
    autoimport_defer_ms = 350,
    local_extract_strategy = 'BEFORE',
}
