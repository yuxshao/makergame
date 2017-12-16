#include <limits.h>
#include <caml/alloc.h>

CAMLprim value unix_realpath(value v_path)
{
  char *path = String_val(v_path);
  char *res = realpath(path, NULL);
  value v_res;
  if (res == NULL) {
    v_res = caml_copy_string("");
  }
  else {
    v_res = caml_copy_string(res);
    free(res);
  }
  return v_res;
}

// ocamlbuild -use-ocamlfind main.native -lflags filename.o
