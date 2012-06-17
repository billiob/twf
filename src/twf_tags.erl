% Nitrogen Web Framework for Erlang
% Copyright (c) 2008-2010 Rusty Klophaus
% Contributions from Tom McNulty (tom.mcnulty@cetiforge.com)
% See MIT-LICENSE for licensing information.

-module (twf_tags).
-author('tom.mcnulty@cetiforge.com').
-include_lib ("twf.hrl").
-define(NO_SHORT_TAGS(TagName),(
    TagName =/= 'div' andalso
    TagName =/= 'span' andalso
    TagName =/= 'label' andalso
    TagName =/= 'textarea' andalso
    TagName =/= 'table' andalso
    TagName =/= 'tr' andalso
    TagName =/= 'th' andalso
    TagName =/= 'td' andalso
    TagName =/= 'iframe')).

-export ([emit_tag/2, emit_tag/3]).

%%%  Empty tags %%%

emit_tag(TagName, Props) ->
    [
        <<"<">>,
        erlang:atom_to_binary(TagName, latin1),
        write_props(Props),
        <<"/>">>
    ].

%%% Tags with child content %%%

% empty text and body
emit_tag(TagName, undefined, Props) when ?NO_SHORT_TAGS(TagName) ->
    emit_tag(TagName, Props);

emit_tag(TagName, Content, Props) ->
    [
        <<"<">>,
        erlang:atom_to_binary(TagName, latin1),
        write_props(Props),
        <<">">>,
        twf:render(Content),
        <<"</">>,
        erlang:atom_to_binary(TagName, latin1),
        <<">">>
    ].

%%% Property display functions %%%

write_props(Props) ->
    lists:map(fun display_property/1, Props).


display_property({Prop}) when is_atom(Prop) ->
    [<<" ">>, Prop];

display_property({Prop, V}) when is_atom(Prop) ->
    display_property({atom_to_binary(Prop, latin1), V});

%% Most HTML tags don't care about a property with an empty string as its value
%% Except for the "value" tag on <option> and other form tags
%% In this case, we emit the 'value' propery even if it's an empty value
display_property({Prop, []}) when Prop =/= "value" -> [];
display_property({Prop, undefined}) when Prop =/= "value" -> [];
display_property({Prop, [undefined]}) when Prop =/= "value" -> [];

display_property({Prop, Value}) when is_integer(Value) ->
    [<<" ">>, Prop, <<"=\"">>, list_to_binary(integer_to_list(Value)),
        <<"\"">>];

display_property({Prop, Value}) when is_binary(Value) ->
    [<<" ">>, Prop, <<"=\"">>, Value, <<"\"">>];

display_property({Prop, Value}) when is_atom(Value) ->
    [<<" ">>, Prop, <<"=\"">>, atom_to_binary(Value, latin1), <<"\"">>];

display_property({Prop, Values}) ->
    Values2 = binary_join(Values),
    [<<" ">>, Prop, <<"=\"">>, Values2, <<"\"">>].

binary_join([]) ->
    [];
binary_join([Head]) ->
    [Head];
binary_join([Head | Tail]) ->
    [ Head, <<" ">> | binary_join(Tail)].
