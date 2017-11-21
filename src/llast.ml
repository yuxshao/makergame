(* Tree to keep track of llvalues for various symbols in a program *)
module L = Llvm
module StringMap = Map.Make(String)

type func = {
  value: L.llvalue;
  typ: L.lltype;
  return: Ast.typ;
  gameobj: string option;
}

type gameobj = {
  gtyp: L.lltype;
  ends: L.llvalue * L.llvalue;
  methods: func StringMap.t;
  events: L.llvalue StringMap.t;
}

type concrete = {
  variables: (L.llvalue * Ast.typ) StringMap.t;
  functions: func StringMap.t;
  gameobjs: gameobj StringMap.t;
  namespaces: namespace StringMap.t;
}
and namespace = Concrete of concrete | Alias of Ast.id_chain
