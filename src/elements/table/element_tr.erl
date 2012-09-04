-module (element_tr).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->
    Cells = Record#tr.cells,
    twf_tags:emit_tag(Twf, tr, Cells, [
        {class, Record#tr.class}
    ]).
