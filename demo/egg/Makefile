egg: egg.mg
	MAKERGAME_PATH=../../lib ../../makergame.native < egg.mg > egg.ll
	llc egg.ll -relocation-model=pic
	gcc egg.s -o egg.exe -L../../runtime -lmakergame \
	  -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++

.PHONY: clean
clean:
	rm egg.ll egg.s egg.exe
