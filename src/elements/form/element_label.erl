-module (element_label).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).


render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, label, Record#label.body, [
        {class, Record#label.class},
        {for, Record#label.for}
    ]).
