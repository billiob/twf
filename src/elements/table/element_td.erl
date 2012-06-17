-module (element_td).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).

render_element(Record) ->
    twf_tags:emit_tag(td, Record#td.body, [
        {class, Record#td.class},
        {align, Record#td.align},
        {valign, Record#td.valign},
        {colspan, Record#td.colspan},
        {rowspan, Record#td.rowspan}
    ]).
