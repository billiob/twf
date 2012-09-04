-module (element_table).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->

    Header = case Record#table.header of
        undefined -> [];
        _ -> twf_tags:emit_tag(thead, Record#table.header, [])
    end,

    Body = case Record#table.rows of
        undefined -> [];
        _ -> twf_tags:emit_tag(tbody, Record#table.rows, [])
    end,

    twf_tags:emit_tag(Twf, table, [Header, Body], [
        {class, Record#table.class}
    ]).
