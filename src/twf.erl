-module (twf).
-include_lib ("twf.hrl").
-include_lib ("cowboy/include/http.hrl").
-export([ render/1
        , init/1
        , request/0
        , path/0
%        , user/0, user/1
        ]).

element_get_module(Element) when is_tuple(Element) ->
    erlang:element(2, Element).


render([]) ->
    [];

render(Binary) when is_binary(Binary) ->
    Binary;

render(Atom) when is_atom(Atom) ->
    erlang:atom_to_binary(atom, latin1);

% TODO    render is_float/is_number/is_bitstring/is_boolean
render(Int) when is_integer(Int) ->
    Int;

render(Elements) when is_list(Elements) ->
    [render(E) || E <- Elements];

render(Element) when is_tuple(Element) ->
    Module = element_get_module(Element),
    {module, Module} = code:ensure_loaded(Module),
    Module:render_element(Element).


init(Req) ->
    Ctx = #context{request = Req},
    erlang:put(context, Ctx).

request() ->
    case erlang:get(context) of
        undefined ->
            undefined;
        Ctx -> Ctx#context.request
    end.

path() ->
    Ctx = erlang:get(context),
    Req = Ctx#context.request,
    Req = request(),
    {Res, Req2}  = cowboy_http_req:path(Req),
    Ctx2 = Ctx#context{request = Req2},
    erlang:put(context, Ctx2),
    Res.
