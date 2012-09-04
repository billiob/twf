-module (element_list).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).


render_element(Twf, Record) ->
    Tag = case Record#list.numbered of
        true -> ol;
        _ -> ul
    end,

    twf_tags:emit_tag(Twf, Tag, Record#list.body, [
        {class, Record#list.class}
    ]).
