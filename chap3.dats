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
end