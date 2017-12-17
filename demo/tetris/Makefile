tetris: tetris.mg
	MAKERGAME_PATH=../../lib ../../makergame.native < tetris.mg > tetris.ll
	llc tetris.ll -relocation-model=pic
	gcc tetris.s ../../runtime/libmakergame.o -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++ -o tetris.exe

.PHONY: timer
timer: tetris.mg
	MAKERGAME_PATH=../../lib ../../makergame.native < tetris.mg > tetris.ll
	llc tetris.ll -relocation-model=pic --time-passes --stats
	gcc tetris.s ../../runtime/libmakergame.o -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++ -o tetris.exe

.PHONY: clean
clean:
	rm tetris.ll tetris.s tetris.exe
