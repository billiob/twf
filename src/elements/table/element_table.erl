-module (element_table).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->

    {Header, Twf2} = case Record#table.header of
        undefined -> {[], Twf};
        _ -> twf_tags:emit_tag(Twf, thead, Record#table.header, [])
    end,

    {Body, Twf3} = case Record#table.rows of
        undefined -> {[], Twf2};
        _ -> twf_tags:emit_tag(Twf, tbody, Record#table.rows, [])
    end,

    twf_tags:emit_tag(Twf3, table, [Header, Body], [
        {class, Record#table.class}
    ]).
