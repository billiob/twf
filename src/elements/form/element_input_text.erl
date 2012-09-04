-module (element_input_text).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).


render_element(Record) ->
    twf_tags:emit_tag(input, Record#input_text.body, [
        {type, <<"text">>},
        {name, Record#input_text.name},
        {class, Record#input_text.class}
    ]).
