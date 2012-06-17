-define(ELEMENT_BASE(Module), module=Module).
-record(template, {?ELEMENT_BASE(element_template), file}).
-record(link, {?ELEMENT_BASE(element_link), class, url, body}).
-record(panel, {?ELEMENT_BASE(element_panel), class, body}).
-record(li, {?ELEMENT_BASE(element_li), class, body}).
-record(list, {?ELEMENT_BASE(element_list), class, numbered=false, body}).
% table
-record(table, {?ELEMENT_BASE(element_table), class, header, rows}).
-record(th, {?ELEMENT_BASE(element_th), class, body,
        align, valign, colspan, rowspan}).
-record(tr, {?ELEMENT_BASE(element_tr), class, cells}).
-record(td, {?ELEMENT_BASE(element_td), class, body,
        align, valign, colspan, rowspan}).


-record(context, {request, user}).
