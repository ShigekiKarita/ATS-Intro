#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"


fun print_dots(i: int): void =
  if i > 0
  then begin
    print ".";
    print_dots (i-1);
  end
  else ()

fun print_row(i: int): void =
  begin
    print_dots i;
    print "Q";
    print_dots (8-i-1);
    print "\n";
  end


typedef int8 = (int,int,int,int,int,int,int,int)

fun print_board(bd: int8): void =
  begin
    print_row (bd.0);
    print_row (bd.1);
    print_row (bd.2);
    print_row (bd.3);
    print_row (bd.4);
    print_row (bd.5);
    print_row (bd.6);
    print_row (bd.7);
    print_newline ()
  end

fun board_get
  (bd: int8, i: int): int =
  if i = 0 then bd.0
  else if i = 1 then bd.1
  else if i = 2 then bd.2
  else if i = 3 then bd.3
  else if i = 4 then bd.4
  else if i = 5 then bd.5
  else if i = 6 then bd.6
  else if i = 7 then bd.7
  else ~1 // end of [if]

fun board_set
  (bd: int8, i: int, j:int): int8 = let
  val (x0, x1, x2, x3, x4, x5, x6, x7) = bd
in
  if i = 0 then let
    val x0 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 1 then let
    val x1 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 2 then let
    val x2 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 3 then let
    val x3 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 4 then let
    val x4 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 5 then let
    val x5 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 6 then let
    val x6 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 7 then let
    val x7 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else bd // end of [if]
end // end of [board_set]


(* test functions *)
fun safety_test1(i0: int, j0: int, i1: int, j1: int): bool =
  j0 != j1 andalso abs (i0 - i1) != abs (j0 - j1)

fun safety_test2(i0: int, j0: int, board: int8, i: int): bool =
  if i >= 0
  then if safety_test1 (i0, j0, i, board_get(board, i))
    then safety_test2(i0, j0, board, i-1)
    else false
  else true

(* DES althorithm *)
fun search(board: int8, i: int, j: int, nsol: int): int =
  if j < 8
  then
    if safety_test2 (i, j, board, i-1)
    then
      let val bd1 = board_set(board, i, j) in
        if i+1 = 8
        then let
          val () = println! ("Solution #", nsol+1, ":\n")
          val () = print_board bd1
        in search(board, i, j+1, nsol+1) end
        else search (bd1, i+1, 0, nsol)
      end
    else search(board, i, j+1, nsol)
  else
    begin
      if i > 0
      then search (board, i-1, board_get(board, i-1) + 1, nsol)
      else nsol
    end


val board = @(0, 1, 2, 3, 4, 5, 6, 7);

implement main0 () = begin
  print (search (board, 0, 0, 0))
end