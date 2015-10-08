#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _(*anon*) = "libats/ML/DATS/list0.dats"



(* 例外 *)
(* 独自の例外 *)
exception FatalError0 of ()
exception FatalError1 of (string)

exception DivisionByZero of ()
fun divexn (x: int, y: int): int =
  if y != 0 then x / y else $raise DivisionByZero()
// end of [divexn]