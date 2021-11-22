(* Problem 4 *)

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

(*  *)
(*  *)
(*  *)
(* Problem 5 *)

signature DICT =
  sig
    type key = string                 (* concrete type *)
    type 'a entry = key * 'a          (* concrete type *)
  
    type 'a dict                      (* abstract type *)
  
    val empty : 'a dict
    val lookup : 'a dict -> key -> 'a option
    val insert : 'a dict * 'a entry -> 'a dict
  end;


structure Trie :> DICT = 
  struct
    type key = string
    type 'a entry = key * 'a
  
    datatype 'a trie = 
      Root of 'a option * 'a trie list
    | Node of 'a option * char * 'a trie list
  
    type 'a dict = 'a trie
  
    val empty = Root(NONE, nil)
  
    (* val lookup: 'a dict -> key -> 'a option *)
    (* tries to find the key in the trie,
    * returns NONE if key is not found in the trie, otherwise
    * returns a SOME(value) corresponding to this key *)
    fun lookup trie key = 
      (* function helper1 is going to traverse throught a given list 
      and find the next corresponding node
      function helper is going to give the result of a query which will call helper1 *)
      let 
        fun helper1 (nil, _) = NONE
          | helper1 (_, nil) = NONE
          | helper1 ((Node (v, ch, lst))::ns, k::ks) = 
              if ch = k
              then helper (Node (v, ch, lst), ks)
              else helper1 (ns, k::ks)
        
        and helper (Root (v, lst), nil) = v
          | helper (Root (_, lst), w) = helper1 (lst, w)
          | helper (Node (v, ch, lst), nil) = v
          | helper (Node (_, _, lst), w) = helper1 (lst, w);
      in
        helper (trie, explode (key))
      end;
  
    (* val insert: 'a dict * 'a entry -> 'a dict *)
    (* Inserts the key and value in the trie *)
    (* If the key is nil, assume that the Root is the destination *)
    fun insert (trie, (key, value)) = 
      (* helper1 is going to add the given key and value to the list
      and helper is going to create nodes *)
      let
        fun helper1 (nil, k::nil, v) = [Node (SOME v, k, nil)]
          | helper1 (nil, k::ks, v) = [Node (NONE, k, helper1 (nil, ks, v))]
          | helper1 ((Node (v1, ch, lst))::ns, k::ks, v) = 
              if ch = k
              then (helper (Node (v1, ch, lst), ks, v))::ns
              else (Node (v1, ch, lst))::(helper1 (ns, k::ks, v))
        
        and helper (Root (_, lst), nil, v) = Root (SOME v, lst)
          | helper (Root (v1, lst), k, v) = Root (v1, helper1 (lst, k, v))
          | helper (Node (_, ch, lst), nil, v) = Node (SOME v, ch, lst)
          | helper (Node (v1, ch, lst), k, v) = Node (v1, ch, helper1 (lst, k, v));
      in
        helper (trie, explode (key), value)
      end;
  end

(* I don't know why the compiler would pop the warning: match nonexhaustive. I think I considered every case. *)


(* val newTrie = Trie.empty; *)
(* val trie1 = Trie.insert(newTrie, ("badge", 2)); *)
(* val trie2 = Trie.insert(trie1, ("bad", 1)); *)
(* val trie3 = Trie.insert(trie2, ("car", 3)); *)
(* val v1 = Trie.lookup trie3 "badge"; *)
(* val v2 = Trie.lookup trie3 "badg"; *)
(* val v3 = Trie.lookup trie3 "car"; *)