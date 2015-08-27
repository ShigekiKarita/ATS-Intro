#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#define BLK 0
#define RED 1
// datatype node = Red of () | Black of ()

sortdef clr = {c: nat | c <= 1}

datatype rbtree (a:t@ype, int, int)  =
  | rbtree_nil (a, BLK, 0)
  | {c, cl, cr:clr | cl <= 1 - c; cr <= 1 - c}
    {bh: nat}
    rbtree_cons (a, c, bh + 1 - c) of
    (int c, rbtree (a, cl, bh), a, rbtree (a, cr, bh))

implement main0 () = () where {

}