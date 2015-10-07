#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"


datatype
list0 (a:t@ype) =
  | list0_nil (a) of () | list0_cons (a) of (a, list0 a)
// end of [list0]

fun{a:t@ype}
list0_append(xs: list0 a, ys: list0 a) : list0 a =
  case+ xs of
  | list0_cons (x, xs) =>
    list0_cons{a}(x, list0_append<a> (xs, ys))
  | list0_nil () => ys


implement main0() = begin
  println! (string_length "hello");
end