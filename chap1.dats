#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"


(* bindings *)
val area = let
  val PI = 3.14 and radius = 10.0
in
  PI * radius * radius
end

local
  val PI = 3.14 and radius = 10.0
in
  val area = PI * radius * radius
end

val area = PI * radius * radius where
{
  val PI = 3.14 and radius = 10.0
}



(* tuples *)
val xyz = ('A', 1, 2) // flat
val x = xyz.0
val (x, y, z) = xyz

(* val xyz = '( 'A', 1, 2.0 ) // box *)



(* records *)
typedef point2D = @{            (* @ : flat, ' : boxed *)
  x = double,
  y = double
}
val theOrigin = @{x=0.1, y=0.2} : point2D
val a = theOrigin.x and b = theOrigin.y
val @{x=a, y=b} = theOrigin
val @{x=a, ...} = theOrigin



implement main0 () =
begin
  print 'H';
  print 'e';
  print 'l';
  print 'l';
  print 'o';
end