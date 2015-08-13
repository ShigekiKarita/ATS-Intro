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


fn println(x: int): void = begin
  print(x);
  print("\n")
end



implement main0 () =
begin
  print (area_of_ring (2., 1.));
  print ("\n");
  println (sqrtsum2 @(2, 1));
  println (sum1 100);
end