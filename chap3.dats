#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* Chapter 3 Functions *)
fn square(x: double): double = x * x
val square = lam (x: double): double => x * x
fn area_of_ring(R: double, r: double): double =
  3.1416 * (square(R) - square(r))

(* arity *)
(* nullary, unary, binary, ternary *)
typedef int2 = (int, int)
fn sqrtsum2(xy: int2): int = let
  val (x,y) = xy
in
  x * x + y * y
end

(* rec fun *)
fun sum1 (n: int): int =
  if n >= 1
  then sum1 (n-1) + n
  else 0

(* 相互再帰 *)
fun p(n: int): int =
  if n > 0 then 1 + q(n-1) else 1
and q(n: int): int =
  if n > 0 then q(n-1) + n * p(n) else 0

fnx isevn (n: int): bool =      (* TCO *)
  if n > 0 then isodd (n-1) else true
and isodd (n: int): bool =
  if n > 0 then isevn (n-1) else false


(* closure *)
fun sum(n: int): int =
  (* loop :: (int, int) -<cloref1> int *)
  let fun loop(i: int, res: int):<cloref1> int =
    if i <= n then loop(i+1, res+i) (* access to n *)
    else res
  in loop(1, 0) end
(* compile into this form *)
fun sum(n: int): int = let
  fun loop(n: int, i: int, res: int): int =
    if i <= n then loop(n, i+1, res+i)
    else res
  in loop(n, 1, 0) end


fun addx(x: int): int -<cloref1> int =
  lam y => x + y


fun rtfind(f: int -> int): int = let
  fun loop(f: int -> int, n: int) : int =
    if f(n) = 0 then n else loop (f, n+1)
  in loop (f, 0) end

fn f(x: int): int = x * x - x - 110


(* puzzle *)
typedef I (a:t@ype) = a -<cloref1> a

fn {a: t0p}
twice(f: I(a)):<cloref> I(a) =
  lam x => f(f(x))

//
typedef I0 = int
typedef I1 = I(I0)
typedef I2 = I(I1)
typedef I3 = I(I2)
//
val Z = 0
val S = lam (x: int): int =<cloref> x + 1
val ans0 = twice<I0>(S)(Z)
val ans1 = twice<I1>(twice<I0>)(S)(Z)
val ans2 = twice<I2>(twice<I1>)(twice<I0>)(S)(Z)
val ans3 = twice<I3>(twice<I2>)(twice<I1>)(twice<I0>)(S)(Z)


(* uncurry *)
fun acker1(m: int, n: int): int =
  if m > 0 then
    if n > 0 then
      acker1 (m-1, acker1 (m, n-1))
    else acker1 (m-1, 1)
  else n+1 // end of [if]

(* curry : deprecated, get memory leak *)
fun acker2(m: int) (n: int): int =
  if m > 0 then
    if n > 0 then
      acker2 (m-1) (acker2 m (n-1))
    else acker2 (m-1) 1
  else n+1 // end of [if]




implement main0 () =
begin
  print (area_of_ring (2., 1.));
  print ("\n");
  println! (sqrtsum2 @(2, 1));
  println! (sum1 1000);         (* sefmentation fault *)
  println! (sum  1000000);
  println! (addx(2)(3));
  println! (rtfind(f));
  println! (rtfind(lam x => x*x-x-110));
  println! (p 10);

  println! ans3;
  println! (acker2(2)(10));
end