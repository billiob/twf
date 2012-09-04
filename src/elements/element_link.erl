-module (element_link).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).


render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, a, Record#link.body, [
        {href, [Record#link.url]},
        {class, Record#link.class}
    ]).
