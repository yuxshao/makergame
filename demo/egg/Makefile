egg: egg.mg
	MAKERGAME_PATH=../../lib ../../makergame.native < egg.mg > egg.ll
	llc egg.ll -relocation-model=pic
	gcc egg.s ../../lib/libmakergame.o -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++ -o egg.exe

.PHONY: clean
clean:
	rm egg.ll egg.s egg.exe
