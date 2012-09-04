-module (element_panel).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, 'div', Record#panel.body, [
        {class, Record#panel.class}
    ]).
