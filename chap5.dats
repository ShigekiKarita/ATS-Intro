#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"


(* staload "libats/ML/SATS/basis.sats" *)
(* staload "libats/ML/SATS/list0.sats" *)
(* staload _(\*anon*\) = "libats/ML/DATS/list0.dats" *)

(* staload "libc/SATS/stdlib.sats" *)

(* Chapter 5 *)

(* template *)
typedef cfun(t1: t@ype, t2: t@ype) = t1 -<cloref1> t2

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
typedef boxstr = boxed(string)
val BA = swap_boxed{boxstr}{boxstr}(AB)
val BA = swap_boxed{...}(AB)
val BA = swap_boxed(AB)         (* type intered *)


datatype list0 (a:t@ype) =
  | list0_nil (a) of ()
  | list0_cons (a) of (a, list0 a)

#define :: list0_cons // writing [::] for list0_cons
#define cons0 list0_cons // writing [cons0] for list0_cons
#define nil0 list0_nil // writing [nil0] for list0_nil
typedef lte (a: t@ype) = (a, a) -> bool



fun {a:t@ype}
list0_length (xs: list0 a): int =
  case+ xs of
  | list0_cons (_, xs) => 1 + list0_length<a> (xs)
  | list0_nil => 0

datatype option0 (a:t@ype) =
  | option0_none (a)
  | option0_some (a) of a

fun divopt(x: int, y: int) : option0 (int) =
  if y != 0 then option0_some{int}(x/y)
  else option0_none

fun {a: t@ype} ok(x: option0 (a)): string =
  case x of
  | option0_some (a) => "OK"
  | option0_none     => "NG"

fun{a: t@ype}{b: t@ype}
list0_foldl(xs: list0 a, z: b, f: (a, b)-<cloref1> b): b =
  case+ xs of
  | x::xs => list0_foldl(xs, f(x, z), f)
  | list0_nil0 => z

fun{a: t@ype}{b: t@ype}
list0_foldr(xs: list0 a, z: b, f: (a, b)-<cloref1> b): b =
  case+ xs of
  | x::xs => f(x, list0_foldr(xs, z, f))
  | list0_nil => z

fun{a:t@ype}
list0_reverse(xs: list0 a): list0 a =
  list0_foldl(xs, list0_nil, lam(x, z) => x::z)

fun{a:t@ype}
list0_append(xs: list0 a, ys: list0 a) : list0 a =
  list0_foldr(xs, ys, lam(x, z) => x::z)

fun{a:t@ype}
list0_reverse_append(xs: list0 a, ys: list0 a) : list0 a =
  list0_append(list0_reverse(xs), ys)

fun{a:t@ype}{b:t@ype}
list0_map(xs: list0 a, f: cfun(a, b)): list0 b =
  list0_foldr(xs, list0_nil, lam(x, z) => f(x)::z)

fun{a:t@ype}
list0_foreach(xs: list0 a, f: cfun(a, void)): void =
  (* list0_foldr(xs, (), lam(x, _) => f(x)) *)
  case+ xs of
  | x :: xs => {
    val _ = f x
    val _ = list0_foreach(xs, f);
  }
  | list0_nil => ()


fun {a: t@ype}
list0_print(xs: list0 a, f: cfun(a, void)): void = {
    val _ = print!("[")
    val _ = list0_foreach(xs, f)
    val _ = println!("]")
  }


(* Merge sort *)
fun {a:t@ype}
merge(xs: list0 a, ys: list0 a, lte: lte a): list0 a =
  case+ xs of
  | x :: xs1 => (
    case+ ys of
    | y :: ys1 =>
      if  x \lte y
      then x :: merge<a>(xs1, ys, lte)
      else y :: merge<a>(xs, ys1, lte)
    | nil0 () => xs
    )
  | nil0 () => ys

fun {a: t@ype}
mergesort(xs: list0 a, lte: lte a): list0 a =
  let val n = list0_length<a>(xs)
  fun msort(xs: list0 a, n: int, lte: lte a) : list0 a =
    if n >= 2
    then split (xs, n, lte, n/2, nil0)
    else xs
  and split(xs: list0 a, n: int, lte: lte a, i: int, xsf: list0 a) : list0 a =
    if i > 0
    then
      let val-cons0 (x, xs) = xs in
        split (xs, n, lte, i-1, cons0{a}(x, xsf))
      end
    else
      let
        val xsf = list0_reverse<a> (xsf) // make sorting stable!
        val xsf = msort (xsf, n/2, lte)
        and xs = msort (xs, n-n/2, lte)
      in
        merge<a> (xsf, xs, lte)
      end // end of [if]
  in
    msort (xs, n, lte)
  end

staload "libc/SATS/stdlib.sats"

implement fprint_val<int>(out, x) =
  $extfcall (void, "fprintf", out, "%3.3i", x)

implement fprint_val<list0 int>(out, xs) = {
  val () = list0_foreach(xs, lam x => $extfcall (void, "fprintf", out, "%3.3i", x))
  }
  // list0_print<int>(xs, lam x => print!(x, ","))

//  $extfcall (void, "fprintf", out, "%3.3i", x)



implement main0 () = {
  val _ = println! (x, y) where {
    val (x, y) = swap<int, double> @(1, 2.0)
  }
  val _ = println! (unbox(BA.0))
  val _ = println! (coin_change(100))
  val _ = println! (ok<int>(divopt(1, 0)))

  val l = 1 :: 3 :: 7 :: nil0// list0_cons(1, list0_cons(3, (list0_cons (2, list0_nil))))
  val r = list0_reverse_append(l, l)
  val _ = list0_print<int>(r, lam x => print!(x, ","))
  val s = merge<int>(l, l, lam (a, b) => a <= b)
  val _ = list0_print<int>(s, lam x => print!(x, ","))


  val out = stdout_ref
  val () = fprintln! (out, 1)
//  val _ = fprintln! (out, s)

  val- option0_some(s) = option0_some{int}(1)
  val _ = println!(s);
}