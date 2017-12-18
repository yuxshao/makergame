tetris: tetris.mg
	MAKERGAME_PATH=../../lib ../../makergame.native < tetris.mg > tetris.ll
	llc tetris.ll -relocation-model=pic
	gcc tetris.s -o tetris.exe -L../../runtime -lmakergame \
	  -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++

.PHONY: timer
timer: tetris.mg
	MAKERGAME_PATH=../../lib ../../makergame.native < tetris.mg > tetris.ll
	llc tetris.ll -relocation-model=pic --time-passes --stats
	gcc tetris.s -o tetris.exe -L../../runtime -lmakergame \
	  -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++

.PHONY: clean
clean:
	rm tetris.ll tetris.s tetris.exe
