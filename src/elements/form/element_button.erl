-module (element_button).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).


render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, button, Record#button.body, [
        {type, <<"text">>},
        {name, Record#button.name},
        {class, Record#button.class}
    ]).
