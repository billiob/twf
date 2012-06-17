-module (element_li).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).

render_element(Record) ->
    twf_tags:emit_tag(li, Record#li.body, [
        {class, Record#li.class}
    ]).
