-module (element_th).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->
    twf_tags:emit_tag(Twf, th, Record#th.body, [
        {class, Record#th.class},
        {align, Record#th.align},
        {valign, Record#th.valign},
        {colspan, Record#th.colspan},
        {rowspan, Record#th.rowspan}
    ]).
