include Filename
external unix_realpath : string -> string = "unix_realpath"

let realpath = function
  | "" -> raise Not_found
  | _ as p -> p

let resolve_file f curr_dir =
  try
    (* Attempt to resolve filenames in the following fashion:
       1) If the path is absolute, load that.
       2) If the path is relative, try:
          a) The current directory of the file loading you.
          c) MAKERGAME_PATH
       TODO: document in LRM
    *)
    if not (Filename.is_relative f) then realpath f
    else
      let cdir_f = Filename.concat curr_dir f in
      let sdir_f = Filename.concat (Sys.getenv "MAKERGAME_PATH") f in
      if Sys.file_exists cdir_f then realpath cdir_f
      else if Sys.file_exists sdir_f then realpath sdir_f
      else raise Not_found
  with
  | Unix.Unix_error (e, _, _) ->
    failwith ("unable to open file \'" ^ f ^ "\': \'" ^ Unix.error_message e ^ "\'")
  | Not_found | Sys_error _ ->
    failwith ("unable to open file \'" ^ f ^ "\'")

let dirname = Filename.dirname;;
