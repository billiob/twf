-module (twf).
-include_lib ("twf.hrl").
-export([ render/1
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
