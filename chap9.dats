#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef String = [n:nat] string (n)

fun string_length{n:nat} (str: string (n)) : size_t (n) = let
  fun loop {i:nat | i <= n} .<n-i>.
    (str: string n, i: size_t i): size_t (n) =
    if string_isnot_atend (str, i)
    then loop (str, succ(i))
    else i
  in loop (str, i2sz(0)) end


// typedef charNZ = [c:char | c <> '\000'] char (c)

typedef sizeLt (n:int) = [i:nat | i < n] size_t (i)


fun string_find {n:nat} (str: string n, c0: char)
  : Option (sizeLt n) = let
  typedef res = sizeLt (n)
  fun loop{i:nat | i <= n}(str: string n, c0: char, i: size_t i)
    : Option (res) =
  begin
    if string_isnot_atend (str, i) then
      if (c0 = str[i]) then Some{res}(i)
      else loop (str, c0, succ(i))
    else None ()
  end
in loop (str, c0, i2sz(0)) end


implement main0() = begin
  println! (string_length "hello");
end