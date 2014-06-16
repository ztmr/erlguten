%%
%% $Id: $
%%
%% Module:  eg_latin2 -- description
%% Created: 16-JUN-2014 21:23
%% Author:  tmr
%%

-module (eg_latin2).
-export ([gen_diffs/0, encode_from_utf8/1]).

utf8_to_il2 (283) -> {236, 'ecaron'};
utf8_to_il2 (353) -> {185, 'scaron'};
utf8_to_il2 (269) -> {232, 'ccaron'};
utf8_to_il2 (345) -> {248, 'rcaron'};
utf8_to_il2 (382) -> {190, 'zcaron'};
utf8_to_il2 (253) -> {253, 'yacute'};
utf8_to_il2 (225) -> {225, 'aacute'};
utf8_to_il2 (237) -> {237, 'iacute'};
utf8_to_il2 (233) -> {233, 'eacute'};
utf8_to_il2 (282) -> {204, 'Ecaron'};
utf8_to_il2 (352) -> {169, 'Scaron'};
utf8_to_il2 (268) -> {200, 'Ccaron'};
utf8_to_il2 (344) -> {216, 'Rcaron'};
utf8_to_il2 (381) -> {174, 'Zcaron'};
utf8_to_il2 (221) -> {221, 'Yacute'};
utf8_to_il2 (193) -> {193, 'Aacute'};
utf8_to_il2 (205) -> {205, 'Iacute'};
utf8_to_il2 (201) -> {201, 'Eacute'};
utf8_to_il2 (X)   -> {X,   '$IDENTITY'}.

encode_from_utf8 (C) ->
    {Code, _} = utf8_to_il2 (C),
    Code.

gen_diffs () ->
    T = [283,353,269,345,382,253,225,237,233,
         282,352,268,344,381,221,193,205,201],
    Tx = lists:map (fun utf8_to_il2/1, T),
    R = [ [Ti, {name, atom_to_list (Tn)}] || {Ti, Tn} <- Tx ],
    {array, lists:flatten (R)}.

%% vim: fdm=syntax:fdn=3:tw=74:ts=2:syn=erlang
