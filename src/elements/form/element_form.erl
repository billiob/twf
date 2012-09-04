-module (element_form).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).


render_element(Record) ->
    twf_tags:emit_tag(form, Record#form.body, [
        {class, Record#form.class},
        {method, Record#form.method}
    ]).
