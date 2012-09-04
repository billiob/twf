-module (element_form).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).


render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, form, Record#form.body, [
        {class, Record#form.class},
        {method, Record#form.method}
    ]).
