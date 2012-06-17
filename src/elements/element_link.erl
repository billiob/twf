-module (element_link).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).


render_element(Record) ->
    twf_tags:emit_tag(a, Record#link.body, [
        {href, [Record#link.url]},
        {class, Record#link.class}
    ]).
