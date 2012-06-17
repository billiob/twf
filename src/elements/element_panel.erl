-module (element_panel).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).

render_element(Record) ->
    twf_tags:emit_tag('div', Record#panel.body, [
        {class, Record#panel.class}
    ]).
