-module (element_list).
-include_lib ("twf.hrl").
-export([ render_element/1
        ]).


render_element(Record) ->
    Tag = case Record#list.numbered of
        true -> ol;
        _ -> ul
    end,

    twf_tags:emit_tag(Tag, Record#list.body, [
        {class, Record#list.class}
    ]).
