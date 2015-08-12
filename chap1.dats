(*
**
** 1つのファイルで構成されたATSプログラムのひな形
**
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

//
// この部分にプログラムを書いてください
//


local
  val PI = 3.14 and radius = 10.0
in (* in of [local] *)
  val area = PI * radius * radius
end // end of [local]

(* ****** ****** *)

implement main0 () = print (area) // [main] のダミー実装
