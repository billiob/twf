-module (element_template).
-include_lib ("twf.hrl").
-export([ render_element/2
        ]).

render_element(Twf, Record) ->
    % Parse the template file...

    File = Record#template.file,
    Template = parse_template(File),

    % Evaluate the template.
    eval(Twf, Template).


%%% PARSE

parse_template(File) ->
    case file:read_file(File) of
        {ok, B} -> parse(B);
        _ ->
            throw({template_not_found, File})
    end.

parse_command(B) ->
    case binary:split(B, [<<"]]]">>]) of
        [B] ->
            throw({invalid_template});
        [B1, B2] ->
            [parse_callback(B1) | parse(B2)]
    end.

parse(<<>>) ->
    [];
parse(B) ->
    case binary:split(B, [<<"[[[">>]) of
        [B] ->
            [B];
        [B1, B2] ->
            [B1 | parse_command(B2)]
    end.



parse_args(B) ->
    case binary:split(B, [<<")">>]) of
        [B] ->
            throw({invalid_template_callback, B});
        [B1, _] ->
            S = "[" ++ erlang:binary_to_list(B1) ++ "].",
            {ok, Tokens, 1} = erl_scan:string(S),
            {ok, Exprs} = erl_parse:parse_exprs(Tokens),
            {value, Value, _} = erl_eval:exprs(Exprs,
                erl_eval:new_bindings()),
            Value
    end.

parse_function(B) ->
    case binary:split(B, [<<"(">>]) of
        [B] ->
            throw({invalid_template_callback, B});
        [B1, B2] ->
            {erlang:list_to_atom(string:strip(erlang:binary_to_list(B1))),
             B2}
    end.

parse_module(B) ->
    case binary:split(B, [<<":">>]) of
        [B] ->
            throw({invalid_template_callback, B});
        [B1, B2] ->
            {erlang:list_to_atom(string:strip(erlang:binary_to_list(B1))),
             B2}
    end.

parse_callback(B) ->
    {Module, B1} = parse_module(B),
    {Function, B2} = parse_function(B1),
    Args = parse_args(B2),

    {callback, Module, Function, Args}.



%%% EVAL

eval(Twf, []) -> {[], Twf};

eval(Twf, [Head | Tail]) when is_binary(Head) ->
    {Elements, Twf2} = eval(Twf, Tail),
    {[Head | Elements], Twf2};

eval(Twf, [Head | Tail]) when is_tuple(Head) ->
    {callback, Module, Function, Args} = Head,

    {module, Module} = code:ensure_loaded(Module),
    {Elements, Twf2} =
    case erlang:function_exported(Module, Function, length(Args)+1) of
        true -> erlang:apply(Module, Function, [Twf |Args]);
        false -> {[], Twf}
    end,
    {ElementsR, Twf3} = twf:render(Twf2, Elements),
    {Elements2, Twf4} = eval(Twf3, Tail),
    {ElementsR2, Twf5} = twf:render(Twf4, Elements2),
    {[ElementsR | ElementsR2], Twf5}.
