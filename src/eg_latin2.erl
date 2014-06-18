%%
%% $Id: $
%%
%% Module:  eg_latin2 -- description
%% Created: 16-JUN-2014 21:23
%% Author:  tmr
%%

-module (eg_latin2).
-export ([gen_diffs/0, encode_from_utf8/1, fix_width/2]).

utf8_to_il2 (283) -> {236, 'ecaron',    1.000, $e};
utf8_to_il2 (353) -> {185, 'scaron',    1.000, $s};
utf8_to_il2 (269) -> {232, 'ccaron',    1.000, $c};
utf8_to_il2 (345) -> {248, 'rcaron',    1.000, $r};
utf8_to_il2 (382) -> {190, 'zcaron',    1.000, $z};
utf8_to_il2 (253) -> {253, 'yacute',    1.000, $y};
utf8_to_il2 (225) -> {225, 'aacute',    1.000, $a};
utf8_to_il2 (237) -> {237, 'iacute',    1.000, $i};
utf8_to_il2 (233) -> {233, 'eacute',    1.000, $e};
utf8_to_il2 (282) -> {204, 'Ecaron',    1.000, $E};
utf8_to_il2 (352) -> {169, 'Scaron',    1.000, $S};
utf8_to_il2 (268) -> {200, 'Ccaron',    1.000, $C};
utf8_to_il2 (344) -> {216, 'Rcaron',    1.000, $R};
utf8_to_il2 (381) -> {174, 'Zcaron',    1.000, $Z};
utf8_to_il2 (221) -> {221, 'Yacute',    1.000, $Y};
utf8_to_il2 (193) -> {193, 'Aacute',    1.000, $A};
utf8_to_il2 (205) -> {205, 'Iacute',    1.000, $I};
utf8_to_il2 (201) -> {201, 'Eacute',    1.000, $E};

utf8_to_il2 (356) -> {141, 'Tcaron',    1.000, $T};
utf8_to_il2 (357) -> {157, 'tcaron',    1.200, $t};
utf8_to_il2 (270) -> {207, 'Dcaron',    1.000, $D};
utf8_to_il2 (271) -> {239, 'dcaron',    1.200, $d};
utf8_to_il2 (327) -> {210, 'Ncaron',    1.000, $N};
utf8_to_il2 (328) -> {242, 'ncaron',    1.000, $n};
utf8_to_il2 (336) -> {217, 'Uring',     1.000, $U};
utf8_to_il2 (367) -> {249, 'uring',     1.000, $u};
utf8_to_il2 (218) -> {218, 'Uacute',    1.000, $U};
utf8_to_il2 (250) -> {250, 'uacute',    1.000, $u};

utf8_to_il2 (X)   -> {X,   '$IDENTITY', 1.000, undefined}.

%% This should be pre-generated
find_utf8_for_il2 (X) ->
    find_utf8_for_il2 (X, supported_utf8_chars ()).

find_utf8_for_il2 (X, []) ->
    utf8_to_il2 (X);
find_utf8_for_il2 (X, [H|T]) ->
    case utf8_to_il2 (H) of
        {X, Name, Coef, BaseChar} -> {H, Name, Coef, BaseChar};
        _                         -> find_utf8_for_il2 (X, T)
    end.

nint (X) when is_integer (X) -> X;
nint (_) -> 0.

fix_width (X, FontHandler) ->
    {_Code, _Name, Correction, BaseChar} = find_utf8_for_il2 (X),
    PdfX = eg_convert:mac2pdf (X),
    PdfXWidth = nint (FontHandler:width (PdfX)),
    BaseWidth = nint (FontHandler:width (BaseChar)),
    case {BaseChar, PdfXWidth, BaseWidth} of
        {undefined, W, _} -> W;            %% no BaseChar -> no conversion at all
        {_,         _, B} -> B*Correction  %% BaseChar -> use base width
    end.

encode_from_utf8 (C) when is_integer (C) ->
    {Code, _, _, _} = utf8_to_il2 (C),
    Code;
encode_from_utf8 (Data) when is_list (Data) ->
    encode_from_utf8 (Data, []).

encode_from_utf8 ([], Acc) -> lists:reverse (Acc);
encode_from_utf8 ([H|T], Acc) ->
    encode_from_utf8 (T, [encode_from_utf8 (H)|Acc]).

gen_diffs () ->
    T = supported_utf8_chars (),
    Tx = lists:map (fun utf8_to_il2/1, T),
    R = [ [Ti, {name, atom_to_list (Tn)}] || {Ti, Tn, _, _} <- Tx ],
    {array, lists:flatten (R)}.

supported_utf8_chars () ->
    [283,353,269,345,382,253,225,237,233,
     282,352,268,344,381,221,193,205,201,
     356,357,270,271,327,328,336,367,218,250].

%% vim: fdm=syntax:fdn=3:tw=74:ts=2:syn=erlang
