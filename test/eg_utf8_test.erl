%%
%% $Id: $
%%
%% Module:  utf8_test -- description
%% Created: 20-JUN-2014 14:23
%% Author:  tmr
%%

-module (eg_utf8_test).
-compile (export_all).

test () ->
    make_pdf (erl2utf ("Žluťoučký koníček zuřivě úpěl ďábelské (k)ódy. 1234567890")).

erl2utf (S) ->
    Fun = fun () -> unicode:characters_to_list (list_to_binary (S)) end,
    case catch (Fun ()) of {'EXIT', _} -> S; R -> R end.

make_pdf (Text) ->
    {ok, Pdf} = weberp_pdf:create ("The Book", "Wild Animals",
                                   "@ztmr", "wildlife animals"),

    eg_pdf:set_pagesize (Pdf, a4),
    eg_pdf:set_page (Pdf, 1),

    eg_pdf:set_font (Pdf, "Times-Roman", 14),
    eg_pdf_lib:moveAndShow (Pdf, 50, 700, Text),

    eg_pdf:set_font (Pdf, "Helvetica", 14),
    eg_pdf_lib:moveAndShow (Pdf, 50, 600, Text),

    eg_pdf:set_font (Pdf, "Courier", 14),
    eg_pdf_lib:moveAndShow (Pdf, 50, 500, Text),

    eg_pdf:set_font(Pdf, "Victorias-Secret", 32),
    eg_pdf_lib:moveAndShow (Pdf, 50, 400, Text),

    eg_pdf:set_font(Pdf, "OCR-A-Digits", 24),
    eg_pdf_lib:moveAndShow (Pdf, 50, 300, Text),

    eg_pdf:set_font(Pdf, "OCR-B-Digits", 24),
    eg_pdf_lib:moveAndShow (Pdf, 50, 200, Text),

    eg_pdf:set_font(Pdf, "Symbol", 14),
    eg_pdf_lib:moveAndShow (Pdf, 50, 100, Text),

    {ok, PdfData} = weberp_pdf:finalize (Pdf),
    ok = file:write_file ("/tmp/xxfoo.pdf", [PdfData]).

%% vim: fdm=syntax:fdn=3:tw=74:ts=2:syn=erlang
