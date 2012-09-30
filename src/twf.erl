-module (twf).
-include_lib ("twf.hrl").
-export([ render/2
        , init/1
        , request/1
        , path/1
        , user/1, user/2
        , q/2
        , method/1
        ]).

element_get_module(Element) when is_tuple(Element) ->
    erlang:element(2, Element).


render(Twf = #twf{}, Binary) when is_binary(Binary) ->
    {Binary, Twf};

render(Twf = #twf{}, Atom) when is_atom(Atom) ->
    {erlang:atom_to_binary(atom, latin1), Twf};

% TODO    render is_float/is_number/is_bitstring/is_boolean
render(Twf = #twf{}, Int) when is_integer(Int) ->
    {Int, Twf};

render(Twf = #twf{}, []) ->
    {[], Twf};

render(Twf = #twf{}, [Head]) ->
    {Elements, Twf2} = render(Twf, Head),
    {[Elements], Twf2};

render(Twf = #twf{}, [Head | Tail]) ->
    {Tags, Twf2} = render(Twf, Head),
    {Tags2, Twf3} = render(Twf2, Tail),
    {[Tags | Tags2], Twf3};

render(Twf = #twf{}, Element) when is_tuple(Element) ->
    Module = element_get_module(Element),
    {module, Module} = code:ensure_loaded(Module),
    Module:render_element(Twf, Element).

init(Req) ->
    #twf{request = Req}.

request(Twf = #twf{}) ->
    Twf#twf.request.

user(Twf = #twf{}) ->
    Twf#twf.user.

user(Twf = #twf{}, Uid) ->
    Twf#twf{user=Uid}.

path(Twf = #twf{}) ->
    {Res, Req2}  = cowboy_req:path(Twf#twf.request),
    Twf2 = Twf#twf{request = Req2},
    {Res, Twf2}.

q(Twf, Binary) ->
    case method(Twf) of
        'POST' ->
            {undefined, Twf}; %TODO
        'GET' ->
            {Res, Req} = cowboy_req:qs_val(Binary, Twf#twf.request),
            Twf2 = Twf#twf{request = Req},
            {Res, Twf2}
    end.

-spec method(Twf) -> cowboy_http:method() when Twf :: #twf{}.
method(Twf) ->
    {Method, _} = cowboy_req:method(Twf#twf.request),
    Method.
