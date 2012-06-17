
-define(ELEMENT_BASE(Module), module=Module).
-record(template, {?ELEMENT_BASE(element_template), file}).

-record(context, {request, user}).
