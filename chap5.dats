#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"


staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _(*anon*) = "libats/ML/DATS/list0.dats"

staload "libc/SATS/stdlib.sats"

(* Chapter 5 *)

(* template *)
typedef cfun(t1: t@ype, t2: t@ype) = t1 -<cloref> t2

fun {a, b, c: t@ype}
compose(f: cfun(a, b), g: cfun(b, c))
  :<cloref1> cfun(a, c) =
  lam x => g(f(x))

fn plus1 = lam(x: int): int =<cloref> x + 1
fn time2 = lam(x: int): int =<cloref> x * 2
val f = compose<int, int, int>(time2, plus1)

fun{a,b:t@ype}swap (xy: (a, b)): (b, a) = (xy.1, xy.0)


(* polymorphic func *)
fun swap_boxed{a: type}{b: type}(xy: (a, b)): (b, a) = (xy.1, xy.0)


typedef int4 = (int, int, int, int)
val theCoins = (1, 5, 10, 25): int4

fun coin_get(n: int): int =
  if n = 0 then theCoins.0
  else if n = 1 then theCoins.1
  else if n = 2 then theCoins.2
  else if n = 3 then theCoins.3
  else ~1 (* erroneous value *)

fun coin_change(sum: int) = let
  fun aux(sum: int, n: int): int =
    if sum > 0 then
      (if n >= 0 then aux(sum, n - 1) +
      aux(sum - coin_get(n), n) else 0)
    else (if sum < 0 then 0 else 1)
  in aux(sum, 3)
end

val AB = (box("A"), box("B"))
val BA = swap_boxed{...}(AB)


datatype list0 (a:t@ype) =
  | list0_nil (a) of ()
  | list0_cons (a) of (a, list0 a)

fun {a:t@ype}
list0_length (xs: list0 a): int =
  case+ xs of
  | list0_cons (_, xs) => 1 + list0_length<a> (xs)
  | list0_nil () => 0

datatype option0 (a:t@ype) =
  | option0_none (a) of ()
  | option0_some (a) of a

fun divopt(x: int, y: int) : option0 (int) =
  if y != 0 then option0_some{int}(x/y)
  else option0_none ()

val s = let val d = divopt(1, 2) in case d of
  | option0_some (a) => 0
  | option0_none () => 1
end

implement main0 () =
{
  val () = println! (x, y) where { val (x, y) = swap<int, double> @(1, 2.0) };
  val () = println! (unbox(BA.0));
  val () = println! (coin_change(100));
  val () = println! (s);
}