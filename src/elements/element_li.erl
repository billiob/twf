-module (element_li).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, li, Record#li.body, [
            {class, Record#li.class}
    ]).
