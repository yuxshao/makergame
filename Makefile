# Make sure ocamlbuild can find opam-managed packages: first run
#
# eval `opam config env`

# Easiest way to build: using ocamlbuild, which in turn uses ocamlfind

.PHONY : all
all : makergame.native runtime/libmakergame.a runtime/libtestergame.a

test : makergame.native runtime/libtestergame.a testall.sh
	./testall.sh

runtime/libmakergame.a:
	gcc -c runtime/libmakergame.cpp -o runtime/libmakergame.o -std=c++11
	ar cr runtime/libmakergame.a runtime/libmakergame.o

runtime/libtestergame.a:
	gcc -c runtime/libtestergame.cpp -o runtime/libtestergame.o -std=c++11
	ar cr runtime/libtestergame.a runtime/libtestergame.o

makergame.native : src/*.ml src/*.mly src/*.mll clean
	ocamlbuild -use-ocamlfind -pkgs llvm,llvm.analysis -cflags -w,+a-4 \
		src/makergame.native -lflags src/filename.o

# "make clean" removes all generated files

.PHONY : clean
clean :
	ocamlbuild -clean
	rm -rf vgcore.*
	rm -rf testall.log *.diff makergame scanner.ml parser.ml parser.mli
	rm -rf runtime/*.o runtime/*.a
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o *.s *.ll *.out *.exe *.err

# More detailed: build using ocamlc/ocamlopt + ocamlfind to locate LLVM

OBJS = file.cmx ast.cmx llast.cmx codegen.cmx parser.cmx scanner.cmx semant.cmx makergame.cmx

makergame : $(OBJS)
	ocamlfind ocamlopt -linkpkg -package llvm -package llvm.analysis $(OBJS) -o makergame

scanner.ml : scanner.mll
	ocamllex scanner.mll

parser.ml parser.mli : parser.mly
	ocamlyacc parser.mly

%.cmo : %.ml
	ocamlc -c $<

%.cmi : %.mli
	ocamlc -c $<

%.cmx : %.ml
	ocamlfind ocamlopt -c -package llvm $<

### Generated by "ocamldep *.ml *.mli" after building scanner.ml and parser.ml
file.cmo :
file.cmx :
llast.cmo :
llast.cmx :
ast.cmo :
ast.cmx :
codegen.cmo : ast.cmo llast.cmo
codegen.cmx : ast.cmx llast.cmx
makergame.cmo : semant.cmo scanner.cmo parser.cmi codegen.cmo ast.cmo llast.cmo file.cmo
makergame.cmx : semant.cmx scanner.cmx parser.cmx codegen.cmx ast.cmx llast.cmx file.cmx
parser.cmo : ast.cmo parser.cmi
parser.cmx : ast.cmx parser.cmi
scanner.cmo : parser.cmi
scanner.cmx : parser.cmx
semant.cmo : ast.cmo file.cmo
semant.cmx : ast.cmx file.cmx
parser.cmi : ast.cmo
