include Parser;;
include Define;;

(* let MY_TEST () =
  for i = 0 to 10000 do
    MESON[] `!P Q R. (if P then Q else R) <=> (P ==> Q) /\ (~P ==> R)`
  done;;
  
let () = MY_TEST();; *)

print_endline "hol_core.ml loaded";;