-module (element_input_text).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).


render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, input, Record#input_text.body, [
        {type, <<"text">>},
        {name, Record#input_text.name},
        {id, Record#input_text.id},
        {class, Record#input_text.class}
    ]).
