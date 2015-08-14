#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* Chapter 5 *)
typedef cfun(t1: t@ype, t2: t@ype) = t1 -<cloref> t2

fun {a, b, c: t@ype}
compose(f: cfun(a, b), g: cfun(b, c))
  :<cloref1> cfun(a, c) =
  lam x => g(f(x))

fn plus1 = lam(x: int): int =<cloref> x + 1
fn time2 = lam(x: int): int =<cloref> x * 2
val f = compose<int, int, int>(time2, plus1)


typede int4 = (int, int, int, int)
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

implement main0 () =
begin
  println!(coin_change(100))
end