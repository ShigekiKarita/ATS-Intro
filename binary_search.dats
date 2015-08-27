#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

datatype bstree =
  | E of ()
  | B of (bstree, string, bstree)

fun bstree_inord(bt: bstree, fwork: string -<cloref1> void): void =
  case+ bt of
  | E () => ()
  | B (btl, x, btr) => {
    val () = bstree_inord(btl, fwork)
    val () = fwork x
    val () = bstree_inord(btr, fwork)
  }

fun bstree_search(bt: bstree, target: string): bool =
  case+ bt of
  | E () => false
  | B (btl, x, btr) =>
    let val sgn = compare (target, x) in
      case+ 0 of
      | _ when sgn < 0 => bstree_search(btl, target)
      | _ when sgn > 0 => bstree_search(btr, target)
      | _ => true
    end

fun bstree_insert(t0: bstree, k0: string): bstree =
  case+ t0 of
  | E () => B (E, k0, E)
  | B (t1, k, t2) =>
    let val sgn = compare (k0, k) in
      case+ 0 of
      | _ when sgn < 0 => B (bstree_insert (t1, k0), k, t2)
      | _ when sgn > 0 => B (t1, k, bstree_insert (t2, k0))
      | _ => t0
    end

val b =
  bstree_insert(
    bstree_insert(
      bstree_insert(E(),
      "hello"),
      ", "),
      "world")

implement main0 () = begin
  println!(bstree_search(b, "hello"));
  println!(bstree_search(b, ", "));
  println!(bstree_search(b, "world"));
  bstree_inord(b, lam x => print!('"', x, "\" "));
end