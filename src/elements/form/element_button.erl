-module (element_button).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).


render_element(Record) ->
    twf_tags:emit_tag(button, Record#button.body, [
        {type, <<"text">>},
        {name, Record#button.name},
        {class, Record#button.class}
    ]).
