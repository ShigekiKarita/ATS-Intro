#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

datatype intopt =
  | intopt_none of ()
  | intopt_some of (int)

datatype wday =
  | Monday of ()
  | Tuesday of ()
  | Wednesday of ()
  | Thursday of ()
  | Friday of ()
  | Saturday of ()
  | Sunday of ()

fun isWeekday(x: wday): bool =
  case x of
  | Saturday() => false
  | Sunday() => false
  | _ => true


datatype charlst =
  | charlst_nil of ()
  | charlst_cons of (char, charlst)


fun charlst_length(cs: charlst): int =
  case cs of
  | charlst_cons (_, cs) => 1 + charlst_length(cs)
  | charlst_nil () => 0

fun charlst_length_tco(cs: charlst): int =
  let fun loop(cs: charlst, n: int): int =
    case cs of
    | charlst_cons (_, cs) => loop (cs, n+1)
    | charlst_nil () => n
  in loop (cs, 0) end

fun charlst_last(cs: charlst): char =
  (* case は non-exatstive な match は warning *)
  (* case+ は error にできる *)
  (* case- は warning を無視できる *)
  case- cs of
  | charlst_cons (c, charlst_nil ()) => c
  | charlst_cons (_, cs1) => charlst_last (cs1)

fun charlst_last(cs: charlst): char =
  let val- charlst_cons (c, cs1) = cs in (* val も case と同様 *)
  case+ cs1 of
  | charlst_nil () => c
  | charlst_cons _ => charlst_last (cs1)
end


implement main0 () = (
  println! (isWeekday(s)) where {
    val  s = Saturday()
  };
  println! (charlst_length(cl)) where {
    val cl =
      charlst_cons('a',
      charlst_cons('b',
      charlst_cons('c',
      charlst_nil())))
  };
)
