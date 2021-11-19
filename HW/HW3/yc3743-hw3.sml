(* Question 1 *)

fun alternate [] = 0
  | alternate (x::xs) = x - (alternate xs);

(* alternate [1, 2, 3, 4]; *)


(* Question 2 *)

fun alternate2 [] op1 op2 = 0
  | alternate2 [x] op1 op2 = x
  | alternate2 (x::xs) op1 op2 = alternate2 ((op1 (x, (hd xs)))::(tl xs)) op2 op1;

(* alternate2 [1, 2, 3, 4] op+ op-; *)


(* Question 3 *)

fun splitup [] = ([], [])
  | splitup (x::xs) = 
      let 
        val ret = splitup xs;
        val pos = #1 ret;
        val neg = #2 ret;
      in 
        if x < 0
        then (pos, x::neg)
        else (x::pos, neg)
      end;

(* splitup [1, ~2, ~4, 0, 1, 3]; *)


(* Question 4 *)

fun composelist x [] = x
  | composelist x (f::fs) = composelist (f x) fs;

(* composelist 5 [ fn x => x+1, fn x => x*2, fn x => x-3 ]; *)
(* composelist "Hello" [ fn x => x ^ " World!", fn x => x ^ " I love", fn x => x ^ " PL!"]; *)


(* Question 5 *)
fun scan_left f y [] = [y]
  | scan_left f y (x::xs) = y::scan_left f (f x y) xs;

(* scan_left (fn x => fn y => x+y) 0 [1, 2, 3]; *)


(* Question 6 *)
fun length [] = 0
  | length (x :: xs ) = 1 + length xs;

fun extend (lst1, lst2) = 
      if (length lst1) < (length lst2)
      then extend ((lst1 @ lst1), lst2)
      else (lst1, lst2);

fun zipRecycle (lst1, []) = []
  | zipRecycle (lst1, lst2) =
      let 
        val ret = extend (lst1, lst2);
        val nlst1 = #1 ret;
        val nlst2 = #2 ret;
      in
        ((hd nlst1), (hd nlst2)) :: zipRecycle ((tl nlst1), (tl nlst2))
      end;

(* zipRecycle ([1,2,3], ["a","b","c"]); *)
(* zipRecycle ([1,2,3,4,5], ["a","b","c"]); *)
(* zipRecycle ([1,2,3], ["a","b","c","d","e"]); *)
(* zipRecycle ([1,2,3], ["a","b","c","d","e","f","g"]); *)


(* Question 7 *)
fun add x y = x + y;

fun bind x y f = 
      if x = NONE then NONE
      else if y = NONE then NONE
      else SOME (f (valOf x) (valOf y));

(* bind (SOME 4) (SOME 3) add; *)
(* bind (SOME 4) NONE add; *)


(* Question 8 *)
fun lookup [] s2 = NONE
  | lookup ((s1:string, i:int)::ps) s2 = 
      if s1 = s2
      then SOME i
      else lookup ps s2;

(* lookup [("hello", 1), ("world", 2)] "hello"; *)


(* Question 9 *)
fun getitem n [] = NONE
  | getitem n (x::xs) = 
      if n = 1 
      then SOME x
      else getitem (n - 1) xs;

(* getitem 2 [1,2,3,4]; *)
(* getitem 5 [1,2,3,4]; *)


(* Question 10 *)
fun getitem2 n [] = NONE
  | getitem2 n (x::xs) = 
      if n = NONE
      then NONE
      else if (valOf n) = 1 
      then SOME x
      else getitem (valOf n - 1) xs;

getitem2 (SOME 2) [1,2,3,4];
getitem2 (SOME 5) [1,2,3,4];
getitem2 NONE [1,2,3];
getitem2 (SOME 5) [];
getitem2 (SOME 5) ([] : int list);