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
  methods: func StringMap.t;
  events: L.llvalue StringMap.t;
}

type namespace = {
  variables: L.llvalue StringMap.t;
  functions: func StringMap.t;
  gameobjs: gameobj StringMap.t;
  namespaces: namespace StringMap.t;
}
