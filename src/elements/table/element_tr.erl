-module (element_tr).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).

render_element(Record) ->
    Cells = Record#tr.cells,
    twf_tags:emit_tag(tr, Cells, [
        {class, Record#tr.class}
    ]).
