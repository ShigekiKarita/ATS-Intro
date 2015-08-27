#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

datatype list0 (a: t@ype) =
  | list0_nil (a) of ()
  | list0_cons (a) of (a, list0 a)

implement main0() = ()