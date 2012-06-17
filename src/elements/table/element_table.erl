-module (element_table).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).

render_element(Record) ->

    Header = case Record#table.header of
        undefined -> [];
        _ -> twf_tags:emit_tag(thead, Record#table.header, [])
    end,

    Body = case Record#table.rows of
        undefined -> [];
        _ -> twf_tags:emit_tag(tbody, Record#table.rows, [])
    end,

    twf_tags:emit_tag(table, [Header, Body], [
        {class, Record#table.class}
    ]).
