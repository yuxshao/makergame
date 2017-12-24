; ModuleID = 'MicroC'
source_filename = "MicroC"

%node = type { %node*, %node*, i1 }
%objref = type { i64, %gameobj* }
%gameobj = type { { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, %node, i64 }
%sfSound = type opaque
%sfSprite = type opaque
%Checker = type { %gameobj, %node, [101 x i1] }
%obj = type { %gameobj, %node, double, double, double, double, double, double, double, double, double, double, %sfSprite* }
%room = type { %gameobj, %node }
%Draw = type { %gameobj, %node, i32, i32, i32, i32, i32, i32, %sfSprite* }
%Block = type { %gameobj, %node, %objref, %sfSprite*, [4 x i32], i32, i32, i32, i32 }
%Piece = type { %gameobj, %node, %objref, i32, i32, i1, i32, i32, i32, i32, i32, %objref, [4 x %objref] }
%Board = type { %gameobj, %node, [24 x [10 x %objref]] }
%game_over = type { %room, %node, i32, i32 }
%main = type { %room, %node }
%game_room = type { %room, %node }

@node.gameobj.head = global %node { %node* @node.gameobj.head, %node* @node.gameobj.head, i1 false }
@last_objid = global i64 0
@object.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"delete_%gameobj = type { { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, %node, i64 }" }
@"variable:file-../../lib/key.mg::p::c" = global %objref zeroinitializer
@"node.object:file-../../lib/key.mg::p::Checker.head" = global %node { %node* @"node.object:file-../../lib/key.mg::p::Checker.head", %node* @"node.object:file-../../lib/key.mg::p::Checker.head", i1 false }
@Checker.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"object:file-../../lib/key.mg::p::Checker.event.draw", void (%objref)* @"delete_%Checker = type { %gameobj, %node, [101 x i1] }" }
@"variable:file-../../lib/key.mg::A" = global i32 0
@"variable:file-../../lib/key.mg::B" = global i32 1
@"variable:file-../../lib/key.mg::C" = global i32 2
@"variable:file-../../lib/key.mg::D" = global i32 3
@"variable:file-../../lib/key.mg::E" = global i32 4
@"variable:file-../../lib/key.mg::F" = global i32 5
@"variable:file-../../lib/key.mg::G" = global i32 6
@"variable:file-../../lib/key.mg::H" = global i32 7
@"variable:file-../../lib/key.mg::I" = global i32 8
@"variable:file-../../lib/key.mg::J" = global i32 9
@"variable:file-../../lib/key.mg::K" = global i32 10
@"variable:file-../../lib/key.mg::L" = global i32 11
@"variable:file-../../lib/key.mg::M" = global i32 12
@"variable:file-../../lib/key.mg::N" = global i32 13
@"variable:file-../../lib/key.mg::O" = global i32 14
@"variable:file-../../lib/key.mg::P" = global i32 15
@"variable:file-../../lib/key.mg::Q" = global i32 16
@"variable:file-../../lib/key.mg::R" = global i32 17
@"variable:file-../../lib/key.mg::S" = global i32 18
@"variable:file-../../lib/key.mg::T" = global i32 19
@"variable:file-../../lib/key.mg::U" = global i32 20
@"variable:file-../../lib/key.mg::V" = global i32 21
@"variable:file-../../lib/key.mg::W" = global i32 22
@"variable:file-../../lib/key.mg::X" = global i32 23
@"variable:file-../../lib/key.mg::Y" = global i32 24
@"variable:file-../../lib/key.mg::Z" = global i32 25
@"variable:file-../../lib/key.mg::Num0" = global i32 26
@"variable:file-../../lib/key.mg::Num1" = global i32 27
@"variable:file-../../lib/key.mg::Num2" = global i32 28
@"variable:file-../../lib/key.mg::Num3" = global i32 29
@"variable:file-../../lib/key.mg::Num4" = global i32 30
@"variable:file-../../lib/key.mg::Num5" = global i32 31
@"variable:file-../../lib/key.mg::Num6" = global i32 32
@"variable:file-../../lib/key.mg::Num7" = global i32 33
@"variable:file-../../lib/key.mg::Num8" = global i32 34
@"variable:file-../../lib/key.mg::Num9" = global i32 35
@"variable:file-../../lib/key.mg::Escape" = global i32 36
@"variable:file-../../lib/key.mg::LControl" = global i32 37
@"variable:file-../../lib/key.mg::LShift" = global i32 38
@"variable:file-../../lib/key.mg::LAlt" = global i32 39
@"variable:file-../../lib/key.mg::LSystem" = global i32 40
@"variable:file-../../lib/key.mg::RControl" = global i32 41
@"variable:file-../../lib/key.mg::RShift" = global i32 42
@"variable:file-../../lib/key.mg::RAlt" = global i32 43
@"variable:file-../../lib/key.mg::RSystem" = global i32 44
@"variable:file-../../lib/key.mg::Menu" = global i32 45
@"variable:file-../../lib/key.mg::LBracket" = global i32 46
@"variable:file-../../lib/key.mg::RBracket" = global i32 47
@"variable:file-../../lib/key.mg::SemiColon" = global i32 48
@"variable:file-../../lib/key.mg::Comma" = global i32 49
@"variable:file-../../lib/key.mg::Period" = global i32 50
@"variable:file-../../lib/key.mg::Quote" = global i32 51
@"variable:file-../../lib/key.mg::Slash" = global i32 52
@"variable:file-../../lib/key.mg::BackSlash" = global i32 53
@"variable:file-../../lib/key.mg::Tilde" = global i32 54
@"variable:file-../../lib/key.mg::Equal" = global i32 55
@"variable:file-../../lib/key.mg::Dash" = global i32 56
@"variable:file-../../lib/key.mg::Space" = global i32 57
@"variable:file-../../lib/key.mg::Return" = global i32 58
@"variable:file-../../lib/key.mg::BackSpace" = global i32 59
@"variable:file-../../lib/key.mg::Tab" = global i32 60
@"variable:file-../../lib/key.mg::PageUp" = global i32 61
@"variable:file-../../lib/key.mg::PageDown" = global i32 62
@"variable:file-../../lib/key.mg::End" = global i32 63
@"variable:file-../../lib/key.mg::Home" = global i32 64
@"variable:file-../../lib/key.mg::Insert" = global i32 65
@"variable:file-../../lib/key.mg::Delete" = global i32 66
@"variable:file-../../lib/key.mg::Add" = global i32 67
@"variable:file-../../lib/key.mg::Subtract" = global i32 68
@"variable:file-../../lib/key.mg::Multiply" = global i32 69
@"variable:file-../../lib/key.mg::Divide" = global i32 70
@"variable:file-../../lib/key.mg::Left" = global i32 71
@"variable:file-../../lib/key.mg::Right" = global i32 72
@"variable:file-../../lib/key.mg::Up" = global i32 73
@"variable:file-../../lib/key.mg::Down" = global i32 74
@"variable:file-../../lib/key.mg::Numpad0" = global i32 75
@"variable:file-../../lib/key.mg::Numpad1" = global i32 76
@"variable:file-../../lib/key.mg::Numpad2" = global i32 77
@"variable:file-../../lib/key.mg::Numpad3" = global i32 78
@"variable:file-../../lib/key.mg::Numpad4" = global i32 79
@"variable:file-../../lib/key.mg::Numpad5" = global i32 80
@"variable:file-../../lib/key.mg::Numpad6" = global i32 81
@"variable:file-../../lib/key.mg::Numpad7" = global i32 82
@"variable:file-../../lib/key.mg::Numpad8" = global i32 83
@"variable:file-../../lib/key.mg::Numpad9" = global i32 84
@"variable:file-../../lib/key.mg::F1" = global i32 85
@"variable:file-../../lib/key.mg::F2" = global i32 86
@"variable:file-../../lib/key.mg::F3" = global i32 87
@"variable:file-../../lib/key.mg::F4" = global i32 88
@"variable:file-../../lib/key.mg::F5" = global i32 89
@"variable:file-../../lib/key.mg::F6" = global i32 90
@"variable:file-../../lib/key.mg::F7" = global i32 91
@"variable:file-../../lib/key.mg::F8" = global i32 92
@"variable:file-../../lib/key.mg::F9" = global i32 93
@"variable:file-../../lib/key.mg::F10" = global i32 94
@"variable:file-../../lib/key.mg::F11" = global i32 95
@"variable:file-../../lib/key.mg::F12" = global i32 96
@"variable:file-../../lib/key.mg::F13" = global i32 97
@"variable:file-../../lib/key.mg::F14" = global i32 98
@"variable:file-../../lib/key.mg::F15" = global i32 99
@"variable:file-../../lib/key.mg::Pause" = global i32 100
@"node.object:file-../../lib/game.mg::room.head" = global %node { %node* @"node.object:file-../../lib/game.mg::room.head", %node* @"node.object:file-../../lib/game.mg::room.head", i1 false }
@room.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"delete_%room = type { %gameobj, %node }" }
@"node.object:file-../../lib/game.mg::obj.head" = global %node { %node* @"node.object:file-../../lib/game.mg::obj.head", %node* @"node.object:file-../../lib/game.mg::obj.head", i1 false }
@obj.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"object:file-../../lib/game.mg::obj.event.draw", void (%objref)* @"delete_%obj = type { %gameobj, %node, double, double, double, double, double, double, double, double, double, double, %sfSprite* }" }
@"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head" = global %node { %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head", %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head", i1 false }
@Draw.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.draw", void (%objref)* @"delete_%Draw = type { %gameobj, %node, i32, i32, i32, i32, i32, i32, %sfSprite* }" }
@"variable::snds::clear" = global %sfSound* null
@"variable::snds::drop" = global %sfSound* null
@"variable::snds::level" = global %sfSound* null
@"variable::snds::move" = global %sfSound* null
@"variable::snds::tetris" = global %sfSound* null
@"variable::snds::turn" = global %sfSound* null
@"variable::snds::music" = global %sfSound* null
@"variable::piece_counts" = global [7 x %objref] zeroinitializer
@"variable::level_count" = global %objref zeroinitializer
@"variable::top_count" = global %objref zeroinitializer
@"variable::score_count" = global %objref zeroinitializer
@"variable::lines_count" = global %objref zeroinitializer
@"variable::possible_pieces" = global [7 x [4 x [3 x i1]]] [[4 x [3 x i1]] [[3 x i1] [i1 false, i1 true, i1 false], [3 x i1] [i1 true, i1 true, i1 true], [3 x i1] zeroinitializer, [3 x i1] zeroinitializer], [4 x [3 x i1]] [[3 x i1] [i1 true, i1 false, i1 false], [3 x i1] [i1 true, i1 true, i1 true], [3 x i1] zeroinitializer, [3 x i1] zeroinitializer], [4 x [3 x i1]] [[3 x i1] [i1 true, i1 true, i1 false], [3 x i1] [i1 false, i1 true, i1 true], [3 x i1] zeroinitializer, [3 x i1] zeroinitializer], [4 x [3 x i1]] [[3 x i1] [i1 true, i1 true, i1 false], [3 x i1] [i1 true, i1 true, i1 false], [3 x i1] zeroinitializer, [3 x i1] zeroinitializer], [4 x [3 x i1]] [[3 x i1] [i1 false, i1 true, i1 true], [3 x i1] [i1 true, i1 true, i1 false], [3 x i1] zeroinitializer, [3 x i1] zeroinitializer], [4 x [3 x i1]] [[3 x i1] [i1 false, i1 false, i1 true], [3 x i1] [i1 true, i1 true, i1 true], [3 x i1] zeroinitializer, [3 x i1] zeroinitializer], [4 x [3 x i1]] [[3 x i1] [i1 false, i1 true, i1 false], [3 x i1] [i1 false, i1 true, i1 false], [3 x i1] [i1 false, i1 true, i1 false], [3 x i1] [i1 false, i1 true, i1 false]]]
@"variable::level_speed" = global [19 x i32] [i32 48, i32 43, i32 38, i32 33, i32 28, i32 23, i32 18, i32 13, i32 8, i32 6, i32 5, i32 5, i32 5, i32 4, i32 4, i32 4, i32 3, i32 3, i32 3]
@"variable::boardOffsetX" = global i32 96
@"variable::boardOffsetY" = global i32 40
@"variable::tile_size" = global i32 8
@"variable::board_width" = global i32 10
@"variable::board_height" = global i32 20
@"variable::points" = global [5 x i32] [i32 0, i32 40, i32 100, i32 300, i32 1200]
@"variable::game_over_fade" = global i32 120
@"variable::game_over_delay" = global i32 120
@"node.object::Block.head" = global %node { %node* @"node.object::Block.head", %node* @"node.object::Block.head", i1 false }
@Block.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"object::Block.event.draw", void (%objref)* @"delete_%Block = type { %gameobj, %node, %objref, %sfSprite*, [4 x i32], i32, i32, i32, i32 }" }
@"node.object::Piece.head" = global %node { %node* @"node.object::Piece.head", %node* @"node.object::Piece.head", i1 false }
@Piece.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::Piece.event.step", void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"delete_%Piece = type { %gameobj, %node, %objref, i32, i32, i1, i32, i32, i32, i32, i32, %objref, [4 x %objref] }" }
@"node.object::Board.head" = global %node { %node* @"node.object::Board.head", %node* @"node.object::Board.head", i1 false }
@Board.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"delete_%Board = type { %gameobj, %node, [24 x [10 x %objref]] }" }
@"node.object::main.head" = global %node { %node* @"node.object::main.head", %node* @"node.object::main.head", i1 false }
@main.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::main.event.step", void (%objref)* @_empty_fn, void (%objref)* @"object::main.event.draw", void (%objref)* @"delete_%main = type { %room, %node }" }
@"node.object::game_room.head" = global %node { %node* @"node.object::game_room.head", %node* @"node.object::game_room.head", i1 false }
@game_room.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::game_room.event.step", void (%objref)* @_empty_fn, void (%objref)* @"object::game_room.event.draw", void (%objref)* @"delete_%game_room = type { %room, %node }" }
@"node.object::game_over.head" = global %node { %node* @"node.object::game_over.head", %node* @"node.object::game_over.head", i1 false }
@game_over.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::game_over.event.step", void (%objref)* @_empty_fn, void (%objref)* @"object::game_over.event.draw", void (%objref)* @"delete_%game_over = type { %room, %node, i32, i32 }" }
@0 = private unnamed_addr constant [5 x i8] c"loop\00"
@1 = private unnamed_addr constant [9 x i8] c"loop end\00"
@2 = private unnamed_addr constant [5 x i8] c"loop\00"
@3 = private unnamed_addr constant [9 x i8] c"loop end\00"
@literal = private unnamed_addr constant [14 x i8] c"snd/clear.ogg\00"
@literal.1 = private unnamed_addr constant [13 x i8] c"snd/drop.ogg\00"
@literal.2 = private unnamed_addr constant [14 x i8] c"snd/level.ogg\00"
@literal.3 = private unnamed_addr constant [14 x i8] c"snd/music.ogg\00"
@literal.4 = private unnamed_addr constant [13 x i8] c"snd/move.ogg\00"
@literal.5 = private unnamed_addr constant [15 x i8] c"snd/tetris.ogg\00"
@literal.6 = private unnamed_addr constant [13 x i8] c"snd/turn.ogg\00"
@literal.7 = private unnamed_addr constant [15 x i8] c"img/pieces.png\00"
@4 = private unnamed_addr constant [5 x i8] c"loop\00"
@5 = private unnamed_addr constant [9 x i8] c"loop end\00"
@literal.8 = private unnamed_addr constant [14 x i8] c"img/title.png\00"
@literal.9 = private unnamed_addr constant [7 x i8] c"Tetris\00"
@literal.10 = private unnamed_addr constant [14 x i8] c"img/board.png\00"
@literal.11 = private unnamed_addr constant [18 x i8] c"img/game_over.png\00"
@literal.12 = private unnamed_addr constant [16 x i8] c"img/numbers.png\00"
@6 = private unnamed_addr constant [5 x i8] c"loop\00"
@7 = private unnamed_addr constant [9 x i8] c"loop end\00"
@8 = private unnamed_addr constant [5 x i8] c"loop\00"
@9 = private unnamed_addr constant [9 x i8] c"loop end\00"

define void @list_add(%node*, %node*) {
entry:
  %prev_ptr = getelementptr inbounds %node, %node* %1, i32 0, i32 0
  %prev = load %node*, %node** %prev_ptr
  %next_ptr = getelementptr inbounds %node, %node* %prev, i32 0, i32 1
  store %node* %0, %node** %prev_ptr
  store %node* %0, %node** %next_ptr
  %2 = getelementptr inbounds %node, %node* %0, i32 0, i32 0
  store %node* %prev, %node** %2
  %3 = getelementptr inbounds %node, %node* %0, i32 0, i32 1
  store %node* %1, %node** %3
  ret void
}

define void @list_rem(%node*) {
entry:
  %prev_ptr = getelementptr inbounds %node, %node* %0, i32 0, i32 0
  %prev = load %node*, %node** %prev_ptr
  %next_ptr = getelementptr inbounds %node, %node* %0, i32 0, i32 1
  %next = load %node*, %node** %next_ptr
  %next_prev = getelementptr inbounds %node, %node* %next, i32 0, i32 0
  %prev_next = getelementptr inbounds %node, %node* %prev, i32 0, i32 1
  %1 = load %node*, %node** %next_prev
  %cmp = icmp eq %node* %1, %0
  br i1 %cmp, label %then, label %else

merge:                                            ; preds = %else, %then
  %2 = load %node*, %node** %prev_next
  %cmp1 = icmp eq %node* %2, %0
  br i1 %cmp1, label %then3, label %else4

then:                                             ; preds = %entry
  store %node* %prev, %node** %next_prev
  br label %merge

else:                                             ; preds = %entry
  br label %merge

merge2:                                           ; preds = %else4, %then3
  ret void

then3:                                            ; preds = %merge
  store %node* %next, %node** %prev_next
  br label %merge2

else4:                                            ; preds = %merge
  br label %merge2
}

define void @_empty_fn(%objref) {
entry:
  ret void
}

define void @"delete_%gameobj = type { { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, %node, i64 }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %objnode = getelementptr inbounds %gameobj, %gameobj* %objptr, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %1 = getelementptr inbounds %gameobj, %gameobj* %objptr, i32 0, i32 0
  ret void
}

declare void @print(i32)

declare void @printb(i1)

declare void @print_float(double)

declare void @printstr(i8*)

define void @"function:file-../../lib/print.mg::i"(i32 %x) {
entry:
  %x1 = alloca i32
  store i32 %x, i32* %x1
  %x2 = load i32, i32* %x1
  call void @print(i32 %x2)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/print.mg::b"(i1 %x) {
entry:
  %x1 = alloca i1
  store i1 %x, i1* %x1
  %x2 = load i1, i1* %x1
  call void @printb(i1 %x2)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/print.mg::f"(double %x) {
entry:
  %x1 = alloca double
  store double %x, double* %x1
  %x2 = load double, double* %x1
  call void @print_float(double %x2)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/print.mg::s"(i8* %x) {
entry:
  %x1 = alloca i8*
  store i8* %x, i8** %x1
  %x2 = load i8*, i8** %x1
  call void @printstr(i8* %x2)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

declare %sfSprite* @load_image(i8*)

declare void @draw_sprite(%sfSprite*, double, double)

declare void @draw_sprite_rect(%sfSprite*, double, double, i32, i32, i32, i32)

declare i32 @sprite_width(%sfSprite*)

declare i32 @sprite_height(%sfSprite*)

define %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* %filename) {
entry:
  %filename1 = alloca i8*
  store i8* %filename, i8** %filename1
  %filename2 = load i8*, i8** %filename1
  %load_image_result = call %sfSprite* @load_image(i8* %filename2)
  ret %sfSprite* %load_image_result

block_end:                                        ; preds = %postret
  ret %sfSprite* null

postret:                                          ; No predecessors!
  br label %block_end
}

define i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %s) {
entry:
  %s1 = alloca %sfSprite*
  store %sfSprite* %s, %sfSprite** %s1
  %s2 = load %sfSprite*, %sfSprite** %s1
  %sprite_width_result = call i32 @sprite_width(%sfSprite* %s2)
  ret i32 %sprite_width_result

block_end:                                        ; preds = %postret
  ret i32 0

postret:                                          ; No predecessors!
  br label %block_end
}

define i32 @"function:file-../../lib/sprite.mg::height"(%sfSprite* %s) {
entry:
  %s1 = alloca %sfSprite*
  store %sfSprite* %s, %sfSprite** %s1
  %s2 = load %sfSprite*, %sfSprite** %s1
  %sprite_height_result = call i32 @sprite_height(%sfSprite* %s2)
  ret i32 %sprite_height_result

block_end:                                        ; preds = %postret
  ret i32 0

postret:                                          ; No predecessors!
  br label %block_end
}

define void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %s, double %x, double %y) {
entry:
  %s1 = alloca %sfSprite*
  store %sfSprite* %s, %sfSprite** %s1
  %x2 = alloca double
  store double %x, double* %x2
  %y3 = alloca double
  store double %y, double* %y3
  %s4 = load %sfSprite*, %sfSprite** %s1
  %x5 = load double, double* %x2
  %y6 = load double, double* %y3
  call void @draw_sprite(%sfSprite* %s4, double %x5, double %y6)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/sprite.mg::render_rect"(%sfSprite* %s, double %x, double %y, [4 x i32] %rect) {
entry:
  %s1 = alloca %sfSprite*
  store %sfSprite* %s, %sfSprite** %s1
  %x2 = alloca double
  store double %x, double* %x2
  %y3 = alloca double
  store double %y, double* %y3
  %rect4 = alloca [4 x i32]
  store [4 x i32] %rect, [4 x i32]* %rect4
  %s5 = load %sfSprite*, %sfSprite** %s1
  %x6 = load double, double* %x2
  %y7 = load double, double* %y3
  %rect8 = load [4 x i32], [4 x i32]* %rect4
  %arr = alloca [4 x i32]
  store [4 x i32] %rect8, [4 x i32]* %arr
  %0 = getelementptr [4 x i32], [4 x i32]* %arr, i32 0, i32 0
  %subscript = load i32, i32* %0
  %rect9 = load [4 x i32], [4 x i32]* %rect4
  %arr10 = alloca [4 x i32]
  store [4 x i32] %rect9, [4 x i32]* %arr10
  %1 = getelementptr [4 x i32], [4 x i32]* %arr10, i32 0, i32 1
  %subscript11 = load i32, i32* %1
  %rect12 = load [4 x i32], [4 x i32]* %rect4
  %arr13 = alloca [4 x i32]
  store [4 x i32] %rect12, [4 x i32]* %arr13
  %2 = getelementptr [4 x i32], [4 x i32]* %arr13, i32 0, i32 2
  %subscript14 = load i32, i32* %2
  %rect15 = load [4 x i32], [4 x i32]* %rect4
  %arr16 = alloca [4 x i32]
  store [4 x i32] %rect15, [4 x i32]* %arr16
  %3 = getelementptr [4 x i32], [4 x i32]* %arr16, i32 0, i32 3
  %subscript17 = load i32, i32* %3
  call void @draw_sprite_rect(%sfSprite* %s5, double %x6, double %y7, i32 %subscript, i32 %subscript11, i32 %subscript14, i32 %subscript17)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

declare %sfSound* @load_sound(i8*)

declare void @play_sound(%sfSound*, i1)

declare void @stop_sound(%sfSound*)

define %sfSound* @"function:file-../../lib/sound.mg::load"(i8* %filename) {
entry:
  %filename1 = alloca i8*
  store i8* %filename, i8** %filename1
  %filename2 = load i8*, i8** %filename1
  %load_sound_result = call %sfSound* @load_sound(i8* %filename2)
  ret %sfSound* %load_sound_result

block_end:                                        ; preds = %postret
  ret %sfSound* null

postret:                                          ; No predecessors!
  br label %block_end
}

define void @"function:file-../../lib/sound.mg::play"(%sfSound* %s) {
entry:
  %s1 = alloca %sfSound*
  store %sfSound* %s, %sfSound** %s1
  %s2 = load %sfSound*, %sfSound** %s1
  call void @play_sound(%sfSound* %s2, i1 false)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/sound.mg::loop"(%sfSound* %s) {
entry:
  %s1 = alloca %sfSound*
  store %sfSound* %s, %sfSound** %s1
  %s2 = load %sfSound*, %sfSound** %s1
  call void @play_sound(%sfSound* %s2, i1 true)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/sound.mg::stop"(%sfSound* %s) {
entry:
  %s1 = alloca %sfSound*
  store %sfSound* %s, %sfSound** %s1
  %s2 = load %sfSound*, %sfSound** %s1
  call void @stop_sound(%sfSound* %s2)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

declare i32 @rand()

declare i32 @rand_max()

define i32 @"function:file-../../lib/math.mg::irandom"(i32 %x) {
entry:
  %x1 = alloca i32
  store i32 %x, i32* %x1
  %rand_result = call i32 @rand()
  %x2 = load i32, i32* %x1
  %tmp = srem i32 %rand_result, %x2
  ret i32 %tmp

block_end:                                        ; preds = %postret
  ret i32 0

postret:                                          ; No predecessors!
  br label %block_end
}

define double @"function:file-../../lib/math.mg::frandom"() {
entry:
  %x = alloca double
  %rand_result = call i32 @rand()
  %0 = sitofp i32 %rand_result to double
  store double %0, double* %x
  %y = alloca double
  %rand_max_result = call i32 @rand_max()
  %1 = sitofp i32 %rand_max_result to double
  store double %1, double* %y
  %x1 = load double, double* %x
  %y2 = load double, double* %y
  %tmp = fdiv double %x1, %y2
  ret double %tmp

block_end:                                        ; preds = %postret
  ret double 0.000000e+00

postret:                                          ; No predecessors!
  br label %block_end
}

declare double @sin(double)

declare double @cos(double)

declare double @tan(double)

declare double @asin(double)

declare double @acos(double)

declare double @atan(double)

declare double @atan2(double, double)

declare double @sqrt(double)

declare void @set_window_size(i32, i32)

declare void @set_window_clear(i32, i32, i32)

declare void @set_window_title(i8*)

define void @"function:file-../../lib/window.mg::set_size"(i32 %w, i32 %h) {
entry:
  %w1 = alloca i32
  store i32 %w, i32* %w1
  %h2 = alloca i32
  store i32 %h, i32* %h2
  %w3 = load i32, i32* %w1
  %h4 = load i32, i32* %h2
  call void @set_window_size(i32 %w3, i32 %h4)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/window.mg::set_clear"(i32 %r, i32 %g, i32 %b) {
entry:
  %r1 = alloca i32
  store i32 %r, i32* %r1
  %g2 = alloca i32
  store i32 %g, i32* %g2
  %b3 = alloca i32
  store i32 %b, i32* %b3
  %r4 = load i32, i32* %r1
  %g5 = load i32, i32* %g2
  %b6 = load i32, i32* %b3
  call void @set_window_clear(i32 %r4, i32 %g5, i32 %b6)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"function:file-../../lib/window.mg::set_title"(i8* %title) {
entry:
  %title1 = alloca i8*
  store i8* %title, i8** %title1
  %title2 = load i8*, i8** %title1
  call void @set_window_title(i8* %title2)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

declare i1 @key_pressed(i32)

define void @"object:file-../../lib/key.mg::p::Checker.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Checker*
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %block_end2
  ret void

block_end2:                                       ; preds = %merge
  br label %block_end

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 101
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i5 = load i32, i32* %i
  %pressed = getelementptr inbounds %Checker, %Checker* %objptr, i32 0, i32 2
  %subscript = getelementptr [101 x i1], [101 x i1]* %pressed, i32 0, i32 %i5
  %i6 = load i32, i32* %i
  %key_pressed_result = call i1 @key_pressed(i32 %i6)
  store i1 %key_pressed_result, i1* %subscript
  %0 = load i1, i1* %subscript
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %1 = load i32, i32* %i
  br label %block_end4

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %while_body
  br label %while
}

define void @"object:file-../../lib/key.mg::p::Checker.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Checker*
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %block_end2
  ret void

block_end2:                                       ; preds = %merge
  br label %block_end

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 101
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i5 = load i32, i32* %i
  %pressed = getelementptr inbounds %Checker, %Checker* %objptr, i32 0, i32 2
  %subscript = getelementptr [101 x i1], [101 x i1]* %pressed, i32 0, i32 %i5
  store i1 false, i1* %subscript
  %0 = load i1, i1* %subscript
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %1 = load i32, i32* %i
  br label %block_end4

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %while_body
  br label %while
}

define void @"delete_%Checker = type { %gameobj, %node, [101 x i1] }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Checker*
  %objnode = getelementptr inbounds %Checker, %Checker* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Checker, %Checker* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define i1 @"function:file-../../lib/key.mg::is_down"(i32 %x) {
entry:
  %x1 = alloca i32
  store i32 %x, i32* %x1
  %x2 = load i32, i32* %x1
  %key_pressed_result = call i1 @key_pressed(i32 %x2)
  ret i1 %key_pressed_result

block_end:                                        ; preds = %postret
  ret i1 false

postret:                                          ; No predecessors!
  br label %block_end
}

define i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %x) {
entry:
  %x1 = alloca i32
  store i32 %x, i32* %x1
  %x2 = load i32, i32* %x1
  %key_pressed_result = call i1 @key_pressed(i32 %x2)
  %x3 = load i32, i32* %x1
  %c = load %objref, %objref* @"variable:file-../../lib/key.mg::p::c"
  %objptr_gen = extractvalue %objref %c, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Checker*
  %pressed = getelementptr inbounds %Checker, %Checker* %objptr, i32 0, i32 2
  %pressed4 = load [101 x i1], [101 x i1]* %pressed
  %arr = alloca [101 x i1]
  store [101 x i1] %pressed4, [101 x i1]* %arr
  %0 = getelementptr [101 x i1], [101 x i1]* %arr, i32 0, i32 %x3
  %subscript = load i1, i1* %0
  %tmp = xor i1 %subscript, true
  %tmp5 = and i1 %key_pressed_result, %tmp
  ret i1 %tmp5

block_end:                                        ; preds = %postret
  ret i1 false

postret:                                          ; No predecessors!
  br label %block_end
}

define i1 @"function:file-../../lib/key.mg::is_released"(i32 %x) {
entry:
  %x1 = alloca i32
  store i32 %x, i32* %x1
  %x2 = load i32, i32* %x1
  %key_pressed_result = call i1 @key_pressed(i32 %x2)
  %tmp = xor i1 %key_pressed_result, true
  %x3 = load i32, i32* %x1
  %c = load %objref, %objref* @"variable:file-../../lib/key.mg::p::c"
  %objptr_gen = extractvalue %objref %c, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Checker*
  %pressed = getelementptr inbounds %Checker, %Checker* %objptr, i32 0, i32 2
  %pressed4 = load [101 x i1], [101 x i1]* %pressed
  %arr = alloca [101 x i1]
  store [101 x i1] %pressed4, [101 x i1]* %arr
  %0 = getelementptr [101 x i1], [101 x i1]* %arr, i32 0, i32 %x3
  %subscript = load i1, i1* %0
  %tmp5 = and i1 %tmp, %subscript
  ret i1 %tmp5

block_end:                                        ; preds = %postret
  ret i1 false

postret:                                          ; No predecessors!
  br label %block_end
}

define void @"function:file-../../lib/key.mg::set_key"() {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%Checker* getelementptr (%Checker, %Checker* null, i32 1) to i32))
  %Checker = bitcast i8* %malloccall to %Checker*
  store %Checker zeroinitializer, %Checker* %Checker
  %Checker_gen = bitcast %Checker* %Checker to %gameobj*
  %Checker_objnode = getelementptr inbounds %Checker, %Checker* %Checker, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %Checker_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %Checker_objnode, %node* @"node.object:file-../../lib/key.mg::p::Checker.head")
  %Checker_parent = getelementptr inbounds %Checker, %Checker* %Checker, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %Checker_parent, i32 0, i32 1
  %marker1 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker1
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %Checker_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %0 = getelementptr inbounds %gameobj, %gameobj* %Checker_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Checker.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %0
  %1 = getelementptr inbounds %gameobj, %gameobj* %Checker_gen, i32 0, i32 2
  store i64 %new_id, i64* %1
  %2 = insertvalue %objref undef, i64 %new_id, 0
  %3 = insertvalue %objref %2, %gameobj* %Checker_gen, 1
  call void @"object:file-../../lib/key.mg::p::Checker.event.create"(%objref %3)
  store %objref %3, %objref* @"variable:file-../../lib/key.mg::p::c"
  %4 = load %objref, %objref* @"variable:file-../../lib/key.mg::p::c"
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

declare void @end_game()

define i1 @"function:file-../../lib/game.mg::obj_alive"(%objref %o) {
entry:
  %o1 = alloca %objref
  store %objref %o, %objref* %o1
  %tail = alloca %node
  %marker = getelementptr inbounds %node, %node* %tail, i32 0, i32 2
  store i1 false, i1* %marker
  %curr_ptr = alloca %node*
  %next_ptr = alloca %node*
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  store %node* @node.gameobj.head, %node** %curr_ptr
  %0 = load %node*, %node** getelementptr inbounds (%node, %node* @node.gameobj.head, i32 0, i32 1)
  store %node* %0, %node** %next_ptr
  br label %while

block_end:                                        ; preds = %postret18
  ret i1 false

while:                                            ; preds = %merge4, %entry
  %curr = load %node*, %node** %next_ptr
  %1 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next = load %node*, %node** %1
  %2 = ptrtoint %node* %curr to i64
  %3 = ptrtoint %node* %next to i64
  %4 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next, %node** %next_ptr
  %cont = icmp ne %node* %curr, @node.gameobj.head
  br i1 %cont, label %while_body, label %merge

while_body:                                       ; preds = %while
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker2 = load i1, i1* %markerptr
  %cont3 = icmp eq i1 %marker2, true
  br i1 %cont3, label %then, label %else13

merge:                                            ; preds = %while
  call void @list_rem(%node* %tail)
  ret i1 false

merge4:                                           ; preds = %merge15, %merge5
  br label %while

then:                                             ; preds = %while_body
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%gameobj, %gameobj* null, i32 0, i32 1) to i64)
  %object = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %object, i32 0, i32 2
  %id = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id, 0
  br i1 %is_removed, label %then6, label %else12

merge5:                                           ; preds = %else12, %merge9
  br label %merge4

then6:                                            ; preds = %then
  %5 = getelementptr inbounds %gameobj, %gameobj* %object, i32 0, i32 2
  %id7 = load i64, i64* %5
  %6 = insertvalue %objref undef, i64 %id7, 0
  %7 = insertvalue %objref %6, %gameobj* %object, 1
  %ref = alloca %objref
  store %objref %7, %objref* %ref
  %x = load %objref, %objref* %ref
  %o8 = load %objref, %objref* %o1
  %tmp_lid = extractvalue %objref %x, 0
  %tmp_rid = extractvalue %objref %o8, 0
  %tmp = icmp eq i64 %tmp_lid, %tmp_rid
  br i1 %tmp, label %then10, label %else

merge9:                                           ; preds = %block_end11, %postret
  br label %merge5

then10:                                           ; preds = %then6
  ret i1 true

postret:                                          ; No predecessors!
  br label %merge9

else:                                             ; preds = %then6
  br label %block_end11

block_end11:                                      ; preds = %else
  br label %merge9

else12:                                           ; preds = %then
  br label %merge5

else13:                                           ; preds = %while_body
  %cont14 = icmp eq %node* %curr, %tail
  br i1 %cont14, label %then16, label %else17

merge15:                                          ; preds = %else17, %then16
  br label %merge4

then16:                                           ; preds = %else13
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  br label %merge15

else17:                                           ; preds = %else13
  br label %merge15

postret18:                                        ; No predecessors!
  br label %block_end
}

define i1 @"function:file-../../lib/game.mg::colliding"(%objref %a, %objref %b) {
entry:
  %a1 = alloca %objref
  store %objref %a, %objref* %a1
  %b2 = alloca %objref
  store %objref %b, %objref* %b2
  %al = alloca double
  %a3 = load %objref, %objref* %a1
  %objptr_gen = extractvalue %objref %a3, 1
  %objptr = bitcast %gameobj* %objptr_gen to %obj*
  %x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %x4 = load double, double* %x
  %a5 = load %objref, %objref* %a1
  %objptr_gen6 = extractvalue %objref %a5, 1
  %objptr7 = bitcast %gameobj* %objptr_gen6 to %obj*
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 5
  %hitbox_offx8 = load double, double* %hitbox_offx
  %tmp = fadd double %x4, %hitbox_offx8
  store double %tmp, double* %al
  %au = alloca double
  %a9 = load %objref, %objref* %a1
  %objptr_gen10 = extractvalue %objref %a9, 1
  %objptr11 = bitcast %gameobj* %objptr_gen10 to %obj*
  %y = getelementptr inbounds %obj, %obj* %objptr11, i32 0, i32 10
  %y12 = load double, double* %y
  %a13 = load %objref, %objref* %a1
  %objptr_gen14 = extractvalue %objref %a13, 1
  %objptr15 = bitcast %gameobj* %objptr_gen14 to %obj*
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr15, i32 0, i32 4
  %hitbox_offy16 = load double, double* %hitbox_offy
  %tmp17 = fadd double %y12, %hitbox_offy16
  store double %tmp17, double* %au
  %ar = alloca double
  %a18 = load %objref, %objref* %a1
  %objptr_gen19 = extractvalue %objref %a18, 1
  %objptr20 = bitcast %gameobj* %objptr_gen19 to %obj*
  %x21 = getelementptr inbounds %obj, %obj* %objptr20, i32 0, i32 11
  %x22 = load double, double* %x21
  %a23 = load %objref, %objref* %a1
  %objptr_gen24 = extractvalue %objref %a23, 1
  %objptr25 = bitcast %gameobj* %objptr_gen24 to %obj*
  %hitbox_offx26 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 5
  %hitbox_offx27 = load double, double* %hitbox_offx26
  %tmp28 = fadd double %x22, %hitbox_offx27
  %a29 = load %objref, %objref* %a1
  %objptr_gen30 = extractvalue %objref %a29, 1
  %objptr31 = bitcast %gameobj* %objptr_gen30 to %obj*
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr31, i32 0, i32 3
  %hitbox_w32 = load double, double* %hitbox_w
  %tmp33 = fadd double %tmp28, %hitbox_w32
  store double %tmp33, double* %ar
  %ad = alloca double
  %a34 = load %objref, %objref* %a1
  %objptr_gen35 = extractvalue %objref %a34, 1
  %objptr36 = bitcast %gameobj* %objptr_gen35 to %obj*
  %y37 = getelementptr inbounds %obj, %obj* %objptr36, i32 0, i32 10
  %y38 = load double, double* %y37
  %a39 = load %objref, %objref* %a1
  %objptr_gen40 = extractvalue %objref %a39, 1
  %objptr41 = bitcast %gameobj* %objptr_gen40 to %obj*
  %hitbox_offy42 = getelementptr inbounds %obj, %obj* %objptr41, i32 0, i32 4
  %hitbox_offy43 = load double, double* %hitbox_offy42
  %tmp44 = fadd double %y38, %hitbox_offy43
  %a45 = load %objref, %objref* %a1
  %objptr_gen46 = extractvalue %objref %a45, 1
  %objptr47 = bitcast %gameobj* %objptr_gen46 to %obj*
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr47, i32 0, i32 2
  %hitbox_h48 = load double, double* %hitbox_h
  %tmp49 = fadd double %tmp44, %hitbox_h48
  store double %tmp49, double* %ad
  %bl = alloca double
  %b50 = load %objref, %objref* %b2
  %objptr_gen51 = extractvalue %objref %b50, 1
  %objptr52 = bitcast %gameobj* %objptr_gen51 to %obj*
  %x53 = getelementptr inbounds %obj, %obj* %objptr52, i32 0, i32 11
  %x54 = load double, double* %x53
  %b55 = load %objref, %objref* %b2
  %objptr_gen56 = extractvalue %objref %b55, 1
  %objptr57 = bitcast %gameobj* %objptr_gen56 to %obj*
  %hitbox_offx58 = getelementptr inbounds %obj, %obj* %objptr57, i32 0, i32 5
  %hitbox_offx59 = load double, double* %hitbox_offx58
  %tmp60 = fadd double %x54, %hitbox_offx59
  store double %tmp60, double* %bl
  %bu = alloca double
  %b61 = load %objref, %objref* %b2
  %objptr_gen62 = extractvalue %objref %b61, 1
  %objptr63 = bitcast %gameobj* %objptr_gen62 to %obj*
  %y64 = getelementptr inbounds %obj, %obj* %objptr63, i32 0, i32 10
  %y65 = load double, double* %y64
  %b66 = load %objref, %objref* %b2
  %objptr_gen67 = extractvalue %objref %b66, 1
  %objptr68 = bitcast %gameobj* %objptr_gen67 to %obj*
  %hitbox_offy69 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 4
  %hitbox_offy70 = load double, double* %hitbox_offy69
  %tmp71 = fadd double %y65, %hitbox_offy70
  store double %tmp71, double* %bu
  %br = alloca double
  %b72 = load %objref, %objref* %b2
  %objptr_gen73 = extractvalue %objref %b72, 1
  %objptr74 = bitcast %gameobj* %objptr_gen73 to %obj*
  %x75 = getelementptr inbounds %obj, %obj* %objptr74, i32 0, i32 11
  %x76 = load double, double* %x75
  %b77 = load %objref, %objref* %b2
  %objptr_gen78 = extractvalue %objref %b77, 1
  %objptr79 = bitcast %gameobj* %objptr_gen78 to %obj*
  %hitbox_offx80 = getelementptr inbounds %obj, %obj* %objptr79, i32 0, i32 5
  %hitbox_offx81 = load double, double* %hitbox_offx80
  %tmp82 = fadd double %x76, %hitbox_offx81
  %b83 = load %objref, %objref* %b2
  %objptr_gen84 = extractvalue %objref %b83, 1
  %objptr85 = bitcast %gameobj* %objptr_gen84 to %obj*
  %hitbox_w86 = getelementptr inbounds %obj, %obj* %objptr85, i32 0, i32 3
  %hitbox_w87 = load double, double* %hitbox_w86
  %tmp88 = fadd double %tmp82, %hitbox_w87
  store double %tmp88, double* %br
  %bd = alloca double
  %b89 = load %objref, %objref* %b2
  %objptr_gen90 = extractvalue %objref %b89, 1
  %objptr91 = bitcast %gameobj* %objptr_gen90 to %obj*
  %y92 = getelementptr inbounds %obj, %obj* %objptr91, i32 0, i32 10
  %y93 = load double, double* %y92
  %b94 = load %objref, %objref* %b2
  %objptr_gen95 = extractvalue %objref %b94, 1
  %objptr96 = bitcast %gameobj* %objptr_gen95 to %obj*
  %hitbox_offy97 = getelementptr inbounds %obj, %obj* %objptr96, i32 0, i32 4
  %hitbox_offy98 = load double, double* %hitbox_offy97
  %tmp99 = fadd double %y93, %hitbox_offy98
  %b100 = load %objref, %objref* %b2
  %objptr_gen101 = extractvalue %objref %b100, 1
  %objptr102 = bitcast %gameobj* %objptr_gen101 to %obj*
  %hitbox_h103 = getelementptr inbounds %obj, %obj* %objptr102, i32 0, i32 2
  %hitbox_h104 = load double, double* %hitbox_h103
  %tmp105 = fadd double %tmp99, %hitbox_h104
  store double %tmp105, double* %bd
  %al106 = load double, double* %al
  %br107 = load double, double* %br
  %tmp108 = fcmp olt double %al106, %br107
  %ar109 = load double, double* %ar
  %bl110 = load double, double* %bl
  %tmp111 = fcmp ogt double %ar109, %bl110
  %tmp112 = and i1 %tmp108, %tmp111
  %au113 = load double, double* %au
  %bd114 = load double, double* %bd
  %tmp115 = fcmp olt double %au113, %bd114
  %tmp116 = and i1 %tmp112, %tmp115
  %ad117 = load double, double* %ad
  %bu118 = load double, double* %bu
  %tmp119 = fcmp ogt double %ad117, %bu118
  %tmp120 = and i1 %tmp116, %tmp119
  ret i1 %tmp120

block_end:                                        ; preds = %postret
  ret i1 false

postret:                                          ; No predecessors!
  br label %block_end
}

define void @"function:file-../../lib/game.mg::end"() {
entry:
  call void @end_game()
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object:file-../../lib/game.mg::room.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %tail = alloca %node
  %marker = getelementptr inbounds %node, %node* %tail, i32 0, i32 2
  store i1 false, i1* %marker
  %curr_ptr = alloca %node*
  %next_ptr = alloca %node*
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  store %node* @node.gameobj.head, %node** %curr_ptr
  %0 = load %node*, %node** getelementptr inbounds (%node, %node* @node.gameobj.head, i32 0, i32 1)
  store %node* %0, %node** %next_ptr
  br label %while

block_end:                                        ; preds = %merge
  ret void

while:                                            ; preds = %merge4, %entry
  %curr = load %node*, %node** %next_ptr
  %1 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next = load %node*, %node** %1
  %2 = ptrtoint %node* %curr to i64
  %3 = ptrtoint %node* %next to i64
  %4 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next, %node** %next_ptr
  %cont = icmp ne %node* %curr, @node.gameobj.head
  br i1 %cont, label %while_body, label %merge

while_body:                                       ; preds = %while
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker2 = load i1, i1* %markerptr
  %cont3 = icmp eq i1 %marker2, true
  br i1 %cont3, label %then, label %else19

merge:                                            ; preds = %while
  call void @list_rem(%node* %tail)
  call void @"function:file-../../lib/key.mg::set_key"()
  br label %block_end

merge4:                                           ; preds = %merge21, %merge5
  br label %while

then:                                             ; preds = %while_body
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%gameobj, %gameobj* null, i32 0, i32 1) to i64)
  %object = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %object, i32 0, i32 2
  %id = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id, 0
  br i1 %is_removed, label %then6, label %else18

merge5:                                           ; preds = %else18, %block_end8
  br label %merge4

then6:                                            ; preds = %then
  %5 = getelementptr inbounds %gameobj, %gameobj* %object, i32 0, i32 2
  %id7 = load i64, i64* %5
  %6 = insertvalue %objref undef, i64 %id7, 0
  %7 = insertvalue %objref %6, %gameobj* %object, 1
  %ref = alloca %objref
  store %objref %7, %objref* %ref
  %r = load %objref, %objref* %ref
  %this9 = load %objref, %objref* %this1
  %tmp_lid = extractvalue %objref %r, 0
  %tmp_rid = extractvalue %objref %this9, 0
  %tmp = icmp ne i64 %tmp_lid, %tmp_rid
  br i1 %tmp, label %then11, label %else

block_end8:                                       ; preds = %merge10
  br label %merge5

merge10:                                          ; preds = %block_end17, %then11
  br label %block_end8

then11:                                           ; preds = %then6
  %r12 = load %objref, %objref* %ref
  %objptr13 = extractvalue %objref %r12, 1
  %8 = bitcast %gameobj* %objptr13 to { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }**
  %tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %8
  %eventptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 3
  %event = load void (%objref)*, void (%objref)** %eventptr
  %eventptr14 = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 1
  %event15 = load void (%objref)*, void (%objref)** %eventptr14
  call void %event(%objref %r12)
  %id16 = getelementptr inbounds %gameobj, %gameobj* %objptr13, i32 0, i32 2
  store i64 0, i64* %id16
  br label %merge10

else:                                             ; preds = %then6
  br label %block_end17

block_end17:                                      ; preds = %else
  br label %merge10

else18:                                           ; preds = %then
  br label %merge5

else19:                                           ; preds = %while_body
  %cont20 = icmp eq %node* %curr, %tail
  br i1 %cont20, label %then22, label %else23

merge21:                                          ; preds = %else23, %then22
  br label %merge4

then22:                                           ; preds = %else19
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  br label %merge21

else23:                                           ; preds = %else19
  br label %merge21
}

define void @"delete_%room = type { %gameobj, %node }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %room*
  %objnode = getelementptr inbounds %room, %room* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %room, %room* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define void @"object:file-../../lib/game.mg::obj.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %obj*
  %x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %le = load double, double* %x
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %hspeed2 = load double, double* %hspeed
  %Asn = fadd double %le, %hspeed2
  store double %Asn, double* %x
  %0 = load double, double* %x
  %y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %le3 = load double, double* %y
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %vspeed4 = load double, double* %vspeed
  %Asn5 = fadd double %le3, %vspeed4
  store double %Asn5, double* %y
  %1 = load double, double* %y
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %spr6 = load %sfSprite*, %sfSprite** %spr
  %x7 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %x8 = load double, double* %x7
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %origin_x9 = load double, double* %origin_x
  %tmp = fsub double %x8, %origin_x9
  %y10 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %y11 = load double, double* %y10
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_y12 = load double, double* %origin_y
  %tmp13 = fsub double %y11, %origin_y12
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %spr6, double %tmp, double %tmp13)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object:file-../../lib/game.mg::obj.event.create"(%objref %this, double %x, double %y, i8* %sprite_name) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca double
  store double %x, double* %x2
  %y3 = alloca double
  store double %y, double* %y3
  %sprite_name4 = alloca i8*
  store i8* %sprite_name, i8** %sprite_name4
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %obj*
  %this5 = load %objref, %objref* %this1
  %objptr_gen6 = extractvalue %objref %this5, 1
  %objptr7 = bitcast %gameobj* %objptr_gen6 to %obj*
  %x8 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 11
  %x9 = load double, double* %x2
  store double %x9, double* %x8
  %0 = load double, double* %x8
  %this10 = load %objref, %objref* %this1
  %objptr_gen11 = extractvalue %objref %this10, 1
  %objptr12 = bitcast %gameobj* %objptr_gen11 to %obj*
  %y13 = getelementptr inbounds %obj, %obj* %objptr12, i32 0, i32 10
  %y14 = load double, double* %y3
  store double %y14, double* %y13
  %1 = load double, double* %y13
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %sprite_name15 = load i8*, i8** %sprite_name4
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* %sprite_name15)
  store %sfSprite* %load_result, %sfSprite** %spr
  %2 = load %sfSprite*, %sfSprite** %spr
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %spr16 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %spr17 = load %sfSprite*, %sfSprite** %spr16
  %width_result = call i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %spr17)
  %3 = sitofp i32 %width_result to double
  %tmp = fmul double %3, 5.000000e-01
  store double %tmp, double* %origin_x
  %4 = load double, double* %origin_x
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %spr18 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %spr19 = load %sfSprite*, %sfSprite** %spr18
  %height_result = call i32 @"function:file-../../lib/sprite.mg::height"(%sfSprite* %spr19)
  %5 = sitofp i32 %height_result to double
  %tmp20 = fmul double %5, 5.000000e-01
  store double %tmp20, double* %origin_y
  %6 = load double, double* %origin_y
  %this21 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.center_hitbox_abs"(%objref %this21, double 0.000000e+00, double 0.000000e+00)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%obj = type { %gameobj, %node, double, double, double, double, double, double, double, double, double, double, %sfSprite* }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %obj*
  %objnode = getelementptr inbounds %obj, %obj* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %obj, %obj* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define void @"object:file-../../lib/game.mg::obj.function.set_hitbox"(%objref %this, double %x, double %y, double %w, double %h) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca double
  store double %x, double* %x2
  %y3 = alloca double
  store double %y, double* %y3
  %w4 = alloca double
  store double %w, double* %w4
  %h5 = alloca double
  store double %h, double* %h5
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %obj*
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %x6 = load double, double* %x2
  store double %x6, double* %hitbox_offx
  %0 = load double, double* %hitbox_offx
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %y7 = load double, double* %y3
  store double %y7, double* %hitbox_offy
  %1 = load double, double* %hitbox_offy
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %w8 = load double, double* %w4
  store double %w8, double* %hitbox_w
  %2 = load double, double* %hitbox_w
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %h9 = load double, double* %h5
  store double %h9, double* %hitbox_h
  %3 = load double, double* %hitbox_h
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object:file-../../lib/game.mg::obj.function.center_hitbox_prop"(%objref %this, double %xprop, double %yprop) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %xprop2 = alloca double
  store double %xprop, double* %xprop2
  %yprop3 = alloca double
  store double %yprop, double* %yprop3
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %obj*
  %sw = alloca double
  %xprop4 = load double, double* %xprop2
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %spr5 = load %sfSprite*, %sfSprite** %spr
  %width_result = call i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %spr5)
  %0 = sitofp i32 %width_result to double
  %tmp = fmul double %xprop4, %0
  store double %tmp, double* %sw
  %sh = alloca double
  %yprop6 = load double, double* %yprop3
  %spr7 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %spr8 = load %sfSprite*, %sfSprite** %spr7
  %height_result = call i32 @"function:file-../../lib/sprite.mg::height"(%sfSprite* %spr8)
  %1 = sitofp i32 %height_result to double
  %tmp9 = fmul double %yprop6, %1
  store double %tmp9, double* %sh
  %sw10 = load double, double* %sw
  %sh11 = load double, double* %sh
  %this12 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.center_hitbox_abs"(%objref %this12, double %sw10, double %sh11)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object:file-../../lib/game.mg::obj.function.center_hitbox_abs"(%objref %this, double %sw, double %sh) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %sw2 = alloca double
  store double %sw, double* %sw2
  %sh3 = alloca double
  store double %sh, double* %sh3
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %obj*
  %sw4 = load double, double* %sw2
  %tmp = fsub double -0.000000e+00, %sw4
  %tmp5 = fdiv double %tmp, 2.000000e+00
  %sh6 = load double, double* %sh3
  %tmp7 = fsub double -0.000000e+00, %sh6
  %tmp8 = fdiv double %tmp7, 2.000000e+00
  %sw9 = load double, double* %sw2
  %sh10 = load double, double* %sh3
  %this11 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.set_hitbox"(%objref %this11, double %tmp5, double %tmp8, double %sw9, double %sh10)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Draw*
  %div = alloca i32
  store i32 1, i32* %div
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %merge18
  ret void

block_end2:                                       ; preds = %merge
  %x = alloca i32
  %x9 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 7
  %x10 = load i32, i32* %x9
  store i32 %x10, i32* %x
  %n = alloca i32
  %this11 = load %objref, %objref* %this1
  %objptr_gen12 = extractvalue %objref %this11, 1
  %objptr13 = bitcast %gameobj* %objptr_gen12 to %Draw*
  %n14 = getelementptr inbounds %Draw, %Draw* %objptr13, i32 0, i32 3
  %n15 = load i32, i32* %n14
  store i32 %n15, i32* %n
  br label %while16

while:                                            ; preds = %block_end6, %entry
  %i3 = load i32, i32* %i
  %digits = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %digits4 = load i32, i32* %digits
  %tmp = sub i32 %digits4, 1
  %tmp5 = icmp slt i32 %i3, %tmp
  br i1 %tmp5, label %while_body, label %merge

while_body:                                       ; preds = %while
  %le = load i32, i32* %div
  %Asn = mul i32 %le, 10
  store i32 %Asn, i32* %div
  %0 = load i32, i32* %div
  %le7 = load i32, i32* %i
  %Asn8 = add i32 %le7, 1
  store i32 %Asn8, i32* %i
  %1 = load i32, i32* %i
  br label %block_end6

merge:                                            ; preds = %while
  br label %block_end2

block_end6:                                       ; preds = %while_body
  br label %while

while16:                                          ; preds = %block_end21, %block_end2
  %div19 = load i32, i32* %div
  %tmp20 = icmp sgt i32 %div19, 0
  br i1 %tmp20, label %while_body17, label %merge18

while_body17:                                     ; preds = %while16
  %d = alloca i32
  %n22 = load i32, i32* %n
  %div23 = load i32, i32* %div
  %tmp24 = sdiv i32 %n22, %div23
  %tmp25 = srem i32 %tmp24, 10
  store i32 %tmp25, i32* %d
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 8
  %spr26 = load %sfSprite*, %sfSprite** %spr
  %x27 = load i32, i32* %x
  %2 = sitofp i32 %x27 to double
  %y = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %y28 = load i32, i32* %y
  %3 = sitofp i32 %y28 to double
  %d29 = load i32, i32* %d
  %tmp30 = mul i32 8, %d29
  %4 = insertvalue [4 x i32] undef, i32 %tmp30, 0
  %5 = insertvalue [4 x i32] %4, i32 0, 1
  %6 = insertvalue [4 x i32] %5, i32 8, 2
  %7 = insertvalue [4 x i32] %6, i32 8, 3
  call void @"function:file-../../lib/sprite.mg::render_rect"(%sfSprite* %spr26, double %2, double %3, [4 x i32] %7)
  %le31 = load i32, i32* %x
  %Asn32 = add i32 %le31, 8
  store i32 %Asn32, i32* %x
  %8 = load i32, i32* %x
  %le33 = load i32, i32* %div
  %Asn34 = sdiv i32 %le33, 10
  store i32 %Asn34, i32* %div
  %9 = load i32, i32* %div
  br label %block_end21

merge18:                                          ; preds = %while16
  br label %block_end

block_end21:                                      ; preds = %while_body17
  br label %while16
}

define void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %this, i32 %x, i32 %y, i32 %digits) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca i32
  store i32 %x, i32* %x2
  %y3 = alloca i32
  store i32 %y, i32* %y3
  %digits4 = alloca i32
  store i32 %digits, i32* %digits4
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Draw*
  %this5 = load %objref, %objref* %this1
  %objptr_gen6 = extractvalue %objref %this5, 1
  %objptr7 = bitcast %gameobj* %objptr_gen6 to %Draw*
  %x8 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 7
  %x9 = load i32, i32* %x2
  store i32 %x9, i32* %x8
  %0 = load i32, i32* %x8
  %this10 = load %objref, %objref* %this1
  %objptr_gen11 = extractvalue %objref %this10, 1
  %objptr12 = bitcast %gameobj* %objptr_gen11 to %Draw*
  %y13 = getelementptr inbounds %Draw, %Draw* %objptr12, i32 0, i32 6
  %y14 = load i32, i32* %y3
  store i32 %y14, i32* %y13
  %1 = load i32, i32* %y13
  %this15 = load %objref, %objref* %this1
  %objptr_gen16 = extractvalue %objref %this15, 1
  %objptr17 = bitcast %gameobj* %objptr_gen16 to %Draw*
  %digits18 = getelementptr inbounds %Draw, %Draw* %objptr17, i32 0, i32 2
  %digits19 = load i32, i32* %digits4
  store i32 %digits19, i32* %digits18
  %2 = load i32, i32* %digits18
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 8
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @literal.12, i32 0, i32 0))
  store %sfSprite* %load_result, %sfSprite** %spr
  %3 = load %sfSprite*, %sfSprite** %spr
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%Draw = type { %gameobj, %node, i32, i32, i32, i32, i32, i32, %sfSprite* }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Draw*
  %objnode = getelementptr inbounds %Draw, %Draw* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Draw, %Draw* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define void @"function::snds::load"() {
entry:
  %load_result = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal, i32 0, i32 0))
  store %sfSound* %load_result, %sfSound** @"variable::snds::clear"
  %0 = load %sfSound*, %sfSound** @"variable::snds::clear"
  %load_result1 = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @literal.1, i32 0, i32 0))
  store %sfSound* %load_result1, %sfSound** @"variable::snds::drop"
  %1 = load %sfSound*, %sfSound** @"variable::snds::drop"
  %load_result2 = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.2, i32 0, i32 0))
  store %sfSound* %load_result2, %sfSound** @"variable::snds::level"
  %2 = load %sfSound*, %sfSound** @"variable::snds::level"
  %load_result3 = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.3, i32 0, i32 0))
  store %sfSound* %load_result3, %sfSound** @"variable::snds::music"
  %3 = load %sfSound*, %sfSound** @"variable::snds::music"
  %load_result4 = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @literal.4, i32 0, i32 0))
  store %sfSound* %load_result4, %sfSound** @"variable::snds::move"
  %4 = load %sfSound*, %sfSound** @"variable::snds::move"
  %load_result5 = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @literal.5, i32 0, i32 0))
  store %sfSound* %load_result5, %sfSound** @"variable::snds::tetris"
  %5 = load %sfSound*, %sfSound** @"variable::snds::tetris"
  %load_result6 = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @literal.6, i32 0, i32 0))
  store %sfSound* %load_result6, %sfSound** @"variable::snds::turn"
  %6 = load %sfSound*, %sfSound** @"variable::snds::turn"
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define i32 @"function::current_speed"() {
entry:
  %lv = alloca i32
  %level_count = load %objref, %objref* @"variable::level_count"
  %objptr_gen = extractvalue %objref %level_count, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %n1 = load i32, i32* %n
  store i32 %n1, i32* %lv
  %lv2 = load i32, i32* %lv
  %tmp = icmp slt i32 %lv2, 19
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge
  ret i32 0

merge:                                            ; preds = %merge6, %postret
  br label %block_end

then:                                             ; preds = %entry
  %lv3 = load i32, i32* %lv
  %level_speed = load [19 x i32], [19 x i32]* @"variable::level_speed"
  %arr = alloca [19 x i32]
  store [19 x i32] %level_speed, [19 x i32]* %arr
  %0 = getelementptr [19 x i32], [19 x i32]* %arr, i32 0, i32 %lv3
  %subscript = load i32, i32* %0
  ret i32 %subscript

postret:                                          ; No predecessors!
  br label %merge

else:                                             ; preds = %entry
  %lv4 = load i32, i32* %lv
  %tmp5 = icmp slt i32 %lv4, 29
  br i1 %tmp5, label %then7, label %else9

merge6:                                           ; preds = %postret10, %postret8
  br label %merge

then7:                                            ; preds = %else
  ret i32 2

postret8:                                         ; No predecessors!
  br label %merge6

else9:                                            ; preds = %else
  ret i32 1

postret10:                                        ; No predecessors!
  br label %merge6
}

define void @"object::Block.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %draw_x = alloca double
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x2 = load i32, i32* %x
  %0 = sitofp i32 %x2 to double
  store double %0, double* %draw_x
  %draw_y = alloca double
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y3 = load i32, i32* %y
  %1 = sitofp i32 %y3 to double
  store double %1, double* %draw_y
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %piece4 = load %objref, %objref* %piece
  %tmp_lid = extractvalue %objref %piece4, 0
  %tmp = icmp ne i64 %tmp_lid, 0
  br i1 %tmp, label %then, label %else40

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end41, %block_end5
  %le = load double, double* %draw_x
  %tile_size = load i32, i32* @"variable::tile_size"
  %2 = sitofp i32 %tile_size to double
  %Asn = fmul double %le, %2
  store double %Asn, double* %draw_x
  %3 = load double, double* %draw_x
  %le42 = load double, double* %draw_y
  %tile_size43 = load i32, i32* @"variable::tile_size"
  %4 = sitofp i32 %tile_size43 to double
  %Asn44 = fmul double %le42, %4
  store double %Asn44, double* %draw_y
  %5 = load double, double* %draw_y
  %le45 = load double, double* %draw_x
  %boardOffsetX = load i32, i32* @"variable::boardOffsetX"
  %6 = sitofp i32 %boardOffsetX to double
  %Asn46 = fadd double %le45, %6
  store double %Asn46, double* %draw_x
  %7 = load double, double* %draw_x
  %le47 = load double, double* %draw_y
  %boardOffsetY = load i32, i32* @"variable::boardOffsetY"
  %8 = sitofp i32 %boardOffsetY to double
  %Asn48 = fadd double %le47, %8
  store double %Asn48, double* %draw_y
  %9 = load double, double* %draw_y
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %s49 = load %sfSprite*, %sfSprite** %s
  %draw_x50 = load double, double* %draw_x
  %draw_y51 = load double, double* %draw_y
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_rect52 = load [4 x i32], [4 x i32]* %type_rect
  call void @"function:file-../../lib/sprite.mg::render_rect"(%sfSprite* %s49, double %draw_x50, double %draw_y51, [4 x i32] %type_rect52)
  br label %block_end

then:                                             ; preds = %entry
  %piece6 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %piece7 = load %objref, %objref* %piece6
  %objptr_gen8 = extractvalue %objref %piece7, 1
  %objptr9 = bitcast %gameobj* %objptr_gen8 to %Piece*
  %active = getelementptr inbounds %Piece, %Piece* %objptr9, i32 0, i32 5
  %active10 = load i1, i1* %active
  %tmp11 = xor i1 %active10, true
  br i1 %tmp11, label %then13, label %else

block_end5:                                       ; preds = %merge12
  br label %merge

merge12:                                          ; preds = %block_end21, %block_end14
  br label %block_end5

then13:                                           ; preds = %then
  %x15 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x16 = load i32, i32* %x15
  %10 = sitofp i32 %x16 to double
  %tmp17 = fadd double %10, 1.350000e+01
  store double %tmp17, double* %draw_x
  %11 = load double, double* %draw_x
  %y18 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y19 = load i32, i32* %y18
  %tmp20 = add i32 %y19, 9
  %12 = sitofp i32 %tmp20 to double
  store double %12, double* %draw_y
  %13 = load double, double* %draw_y
  br label %block_end14

block_end14:                                      ; preds = %then13
  br label %merge12

else:                                             ; preds = %then
  %x22 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x23 = load i32, i32* %x22
  %piece24 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %piece25 = load %objref, %objref* %piece24
  %objptr_gen26 = extractvalue %objref %piece25, 1
  %objptr27 = bitcast %gameobj* %objptr_gen26 to %Piece*
  %x28 = getelementptr inbounds %Piece, %Piece* %objptr27, i32 0, i32 10
  %x29 = load i32, i32* %x28
  %tmp30 = add i32 %x23, %x29
  %14 = sitofp i32 %tmp30 to double
  store double %14, double* %draw_x
  %15 = load double, double* %draw_x
  %y31 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y32 = load i32, i32* %y31
  %piece33 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %piece34 = load %objref, %objref* %piece33
  %objptr_gen35 = extractvalue %objref %piece34, 1
  %objptr36 = bitcast %gameobj* %objptr_gen35 to %Piece*
  %y37 = getelementptr inbounds %Piece, %Piece* %objptr36, i32 0, i32 9
  %y38 = load i32, i32* %y37
  %tmp39 = add i32 %y32, %y38
  %16 = sitofp i32 %tmp39 to double
  store double %16, double* %draw_y
  %17 = load double, double* %draw_y
  br label %block_end21

block_end21:                                      ; preds = %else
  br label %merge12

else40:                                           ; preds = %entry
  br label %block_end41

block_end41:                                      ; preds = %else40
  br label %merge
}

define void @"object::Block.event.create"(%objref %this, i32 %x, i32 %y, %objref %p) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca i32
  store i32 %x, i32* %x2
  %y3 = alloca i32
  store i32 %y, i32* %y3
  %p4 = alloca %objref
  store %objref %p, %objref* %p4
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @literal.7, i32 0, i32 0))
  store %sfSprite* %load_result, %sfSprite** %s
  %0 = load %sfSprite*, %sfSprite** %s
  %this5 = load %objref, %objref* %this1
  %objptr_gen6 = extractvalue %objref %this5, 1
  %objptr7 = bitcast %gameobj* %objptr_gen6 to %Block*
  %x8 = getelementptr inbounds %Block, %Block* %objptr7, i32 0, i32 8
  %x9 = load i32, i32* %x2
  store i32 %x9, i32* %x8
  %1 = load i32, i32* %x8
  %this10 = load %objref, %objref* %this1
  %objptr_gen11 = extractvalue %objref %this10, 1
  %objptr12 = bitcast %gameobj* %objptr_gen11 to %Block*
  %y13 = getelementptr inbounds %Block, %Block* %objptr12, i32 0, i32 7
  %y14 = load i32, i32* %y3
  store i32 %y14, i32* %y13
  %2 = load i32, i32* %y13
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %p15 = load %objref, %objref* %p4
  store %objref %p15, %objref* %piece
  %3 = load %objref, %objref* %piece
  %this16 = load %objref, %objref* %this1
  call void @"object::Block.function.setType"(%objref %this16, i32 0, i32 0)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%Block = type { %gameobj, %node, %objref, %sfSprite*, [4 x i32], i32, i32, i32, i32 }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Block*
  %objnode = getelementptr inbounds %Block, %Block* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Block, %Block* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define void @"object::Block.function.settlePosition"(%objref %this, %objref %board) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %board2 = alloca %objref
  store %objref %board, %objref* %board2
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %piece3 = load %objref, %objref* %piece
  %objptr_gen4 = extractvalue %objref %piece3, 1
  %objptr5 = bitcast %gameobj* %objptr_gen4 to %Piece*
  %x6 = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 10
  %x7 = load i32, i32* %x6
  %x8 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x9 = load i32, i32* %x8
  %tmp = add i32 %x7, %x9
  store i32 %tmp, i32* %x
  %0 = load i32, i32* %x
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %piece10 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %piece11 = load %objref, %objref* %piece10
  %objptr_gen12 = extractvalue %objref %piece11, 1
  %objptr13 = bitcast %gameobj* %objptr_gen12 to %Piece*
  %y14 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 9
  %y15 = load i32, i32* %y14
  %y16 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y17 = load i32, i32* %y16
  %tmp18 = add i32 %y15, %y17
  store i32 %tmp18, i32* %y
  %1 = load i32, i32* %y
  %piece19 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  store %objref zeroinitializer, %objref* %piece19
  %2 = load %objref, %objref* %piece19
  %y20 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y21 = load i32, i32* %y20
  %tmp22 = icmp sle i32 %y21, 0
  br i1 %tmp22, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end29, %block_end23
  %x30 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x31 = load i32, i32* %x30
  %y32 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y33 = load i32, i32* %y32
  %board34 = load %objref, %objref* %board2
  %objptr_gen35 = extractvalue %objref %board34, 1
  %objptr36 = bitcast %gameobj* %objptr_gen35 to %Board*
  %pieces = getelementptr inbounds %Board, %Board* %objptr36, i32 0, i32 2
  %subscript = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces, i32 0, i32 %y33
  %subscript37 = getelementptr [10 x %objref], [10 x %objref]* %subscript, i32 0, i32 %x31
  %this38 = load %objref, %objref* %this1
  store %objref %this38, %objref* %subscript37
  %3 = load %objref, %objref* %subscript37
  br label %block_end

then:                                             ; preds = %entry
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%game_over* getelementptr (%game_over, %game_over* null, i32 1) to i32))
  %game_over = bitcast i8* %malloccall to %game_over*
  store %game_over zeroinitializer, %game_over* %game_over
  %game_over_gen = bitcast %game_over* %game_over to %gameobj*
  %game_over_objnode = getelementptr inbounds %game_over, %game_over* %game_over, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %game_over_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %game_over_objnode, %node* @"node.object::game_over.head")
  %game_over_parent = getelementptr inbounds %game_over, %game_over* %game_over, i32 0, i32 0
  %room_objnode = getelementptr inbounds %room, %room* %game_over_parent, i32 0, i32 1
  %marker24 = getelementptr inbounds %node, %node* %room_objnode, i32 0, i32 2
  store i1 true, i1* %marker24
  call void @list_add(%node* %room_objnode, %node* @"node.object:file-../../lib/game.mg::room.head")
  %room_parent = getelementptr inbounds %room, %room* %game_over_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 1
  %marker25 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker25
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %4 = getelementptr inbounds %gameobj, %gameobj* %game_over_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @game_over.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %4
  %5 = getelementptr inbounds %gameobj, %gameobj* %game_over_gen, i32 0, i32 2
  store i64 %new_id, i64* %5
  %6 = insertvalue %objref undef, i64 %new_id, 0
  %7 = insertvalue %objref %6, %gameobj* %game_over_gen, 1
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen26 = extractvalue %objref %score_count, 1
  %objptr27 = bitcast %gameobj* %objptr_gen26 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 3
  %n28 = load i32, i32* %n
  call void @"object::game_over.event.create"(%objref %7, i32 %n28)
  ret void

block_end23:                                      ; preds = %postret
  br label %merge

postret:                                          ; No predecessors!
  br label %block_end23

else:                                             ; preds = %entry
  br label %block_end29

block_end29:                                      ; preds = %else
  br label %merge
}

define void @"object::Block.function.rotateRight"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %this2 = load %objref, %objref* %this1
  call void @"object::Block.function.rotateLeft"(%objref %this2)
  %this3 = load %objref, %objref* %this1
  call void @"object::Block.function.rotateLeft"(%objref %this3)
  %this4 = load %objref, %objref* %this1
  call void @"object::Block.function.rotateLeft"(%objref %this4)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::Block.function.rotateLeft"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %newX = alloca i32
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %y2 = load i32, i32* %y
  %tmp = sub i32 0, %y2
  store i32 %tmp, i32* %newX
  %newY = alloca i32
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x3 = load i32, i32* %x
  store i32 %x3, i32* %newY
  %y4 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %newY5 = load i32, i32* %newY
  store i32 %newY5, i32* %y4
  %0 = load i32, i32* %y4
  %x6 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %newX7 = load i32, i32* %newX
  store i32 %newX7, i32* %x6
  %1 = load i32, i32* %x6
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::Block.function.setType"(%objref %this, i32 %x, i32 %y) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca i32
  store i32 %x, i32* %x2
  %y3 = alloca i32
  store i32 %y, i32* %y3
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %x4 = load i32, i32* %x2
  store i32 %x4, i32* %type_x
  %0 = load i32, i32* %type_x
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %y5 = load i32, i32* %y3
  store i32 %y5, i32* %type_y
  %1 = load i32, i32* %type_y
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %tile_size = load i32, i32* @"variable::tile_size"
  %x6 = load i32, i32* %x2
  %tmp = mul i32 %tile_size, %x6
  %tile_size7 = load i32, i32* @"variable::tile_size"
  %y8 = load i32, i32* %y3
  %tmp9 = mul i32 %tile_size7, %y8
  %tile_size10 = load i32, i32* @"variable::tile_size"
  %tile_size11 = load i32, i32* @"variable::tile_size"
  %2 = insertvalue [4 x i32] undef, i32 %tmp, 0
  %3 = insertvalue [4 x i32] %2, i32 %tmp9, 1
  %4 = insertvalue [4 x i32] %3, i32 %tile_size10, 2
  %5 = insertvalue [4 x i32] %4, i32 %tile_size11, 3
  store [4 x i32] %5, [4 x i32]* %type_rect
  %6 = load [4 x i32], [4 x i32]* %type_rect
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::Piece.event.step"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %active2 = load i1, i1* %active
  %tmp = xor i1 %active2, true
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge95
  ret void

merge:                                            ; preds = %block_end3, %postret
  %Left = load i32, i32* @"variable:file-../../lib/key.mg::Left"
  %is_pressed_result = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Left)
  %Left4 = load i32, i32* @"variable:file-../../lib/key.mg::Left"
  %is_down_result = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Left4)
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %horiz_timer5 = load i32, i32* %horiz_timer
  %tmp6 = icmp eq i32 %horiz_timer5, 0
  %tmp7 = and i1 %is_down_result, %tmp6
  %tmp8 = or i1 %is_pressed_result, %tmp7
  br i1 %tmp8, label %then10, label %else14

then:                                             ; preds = %entry
  ret void

postret:                                          ; No predecessors!
  br label %merge

else:                                             ; preds = %entry
  br label %block_end3

block_end3:                                       ; preds = %else
  br label %merge

merge9:                                           ; preds = %block_end15, %block_end11
  %Right = load i32, i32* @"variable:file-../../lib/key.mg::Right"
  %is_pressed_result16 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Right)
  %Right17 = load i32, i32* @"variable:file-../../lib/key.mg::Right"
  %is_down_result18 = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Right17)
  %horiz_timer19 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %horiz_timer20 = load i32, i32* %horiz_timer19
  %tmp21 = icmp eq i32 %horiz_timer20, 0
  %tmp22 = and i1 %is_down_result18, %tmp21
  %tmp23 = or i1 %is_pressed_result16, %tmp22
  br i1 %tmp23, label %then25, label %else29

then10:                                           ; preds = %merge
  %horiz_timer12 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  store i32 5, i32* %horiz_timer12
  %0 = load i32, i32* %horiz_timer12
  %this13 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveLeft"(%objref %this13)
  br label %block_end11

block_end11:                                      ; preds = %then10
  br label %merge9

else14:                                           ; preds = %merge
  br label %block_end15

block_end15:                                      ; preds = %else14
  br label %merge9

merge24:                                          ; preds = %block_end30, %block_end26
  %Down = load i32, i32* @"variable:file-../../lib/key.mg::Down"
  %is_down_result31 = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Down)
  br i1 %is_down_result31, label %then33, label %else43

then25:                                           ; preds = %merge9
  %horiz_timer27 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  store i32 5, i32* %horiz_timer27
  %1 = load i32, i32* %horiz_timer27
  %this28 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveRight"(%objref %this28)
  br label %block_end26

block_end26:                                      ; preds = %then25
  br label %merge24

else29:                                           ; preds = %merge9
  br label %block_end30

block_end30:                                      ; preds = %else29
  br label %merge24

merge32:                                          ; preds = %block_end44, %block_end34
  %X = load i32, i32* @"variable:file-../../lib/key.mg::X"
  %is_pressed_result45 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %X)
  br i1 %is_pressed_result45, label %then47, label %else49

then33:                                           ; preds = %merge24
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %curr_timer35 = load i32, i32* %curr_timer
  %tmp36 = icmp sgt i32 %curr_timer35, 3
  br i1 %tmp36, label %then38, label %else41

block_end34:                                      ; preds = %merge37
  br label %merge32

merge37:                                          ; preds = %block_end42, %block_end39
  br label %block_end34

then38:                                           ; preds = %then33
  %curr_timer40 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  store i32 3, i32* %curr_timer40
  %2 = load i32, i32* %curr_timer40
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %le = load i32, i32* %drop_points
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %drop_points
  %3 = load i32, i32* %drop_points
  br label %block_end39

block_end39:                                      ; preds = %then38
  br label %merge37

else41:                                           ; preds = %then33
  br label %block_end42

block_end42:                                      ; preds = %else41
  br label %merge37

else43:                                           ; preds = %merge24
  br label %block_end44

block_end44:                                      ; preds = %else43
  br label %merge32

merge46:                                          ; preds = %block_end50, %then47
  %Z = load i32, i32* @"variable:file-../../lib/key.mg::Z"
  %is_pressed_result51 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Z)
  br i1 %is_pressed_result51, label %then53, label %else55

then47:                                           ; preds = %merge32
  %this48 = load %objref, %objref* %this1
  call void @"object::Piece.function.rotateLeft"(%objref %this48)
  br label %merge46

else49:                                           ; preds = %merge32
  br label %block_end50

block_end50:                                      ; preds = %else49
  br label %merge46

merge52:                                          ; preds = %block_end56, %then53
  %Space = load i32, i32* @"variable:file-../../lib/key.mg::Space"
  %is_pressed_result57 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Space)
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %hard_drop58 = load i32, i32* %hard_drop
  %tmp59 = icmp eq i32 %hard_drop58, 0
  %tmp60 = and i1 %is_pressed_result57, %tmp59
  br i1 %tmp60, label %then62, label %else71

then53:                                           ; preds = %merge46
  %this54 = load %objref, %objref* %this1
  call void @"object::Piece.function.rotateRight"(%objref %this54)
  br label %merge52

else55:                                           ; preds = %merge46
  br label %block_end56

block_end56:                                      ; preds = %else55
  br label %merge52

merge61:                                          ; preds = %block_end72, %merge63
  %curr_timer73 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %le74 = load i32, i32* %curr_timer73
  %Asn75 = sub i32 %le74, 1
  store i32 %Asn75, i32* %curr_timer73
  %4 = load i32, i32* %curr_timer73
  %tmp76 = icmp eq i32 %4, 0
  br i1 %tmp76, label %then78, label %else80

then62:                                           ; preds = %merge52
  br label %while

while:                                            ; preds = %block_end66, %then62
  %active64 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %active65 = load i1, i1* %active64
  br i1 %active65, label %while_body, label %merge63

while_body:                                       ; preds = %while
  %drop_points67 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %le68 = load i32, i32* %drop_points67
  %Asn69 = add i32 %le68, 1
  store i32 %Asn69, i32* %drop_points67
  %5 = load i32, i32* %drop_points67
  %this70 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveDown"(%objref %this70)
  br label %block_end66

merge63:                                          ; preds = %while
  br label %merge61

block_end66:                                      ; preds = %while_body
  br label %while

else71:                                           ; preds = %merge52
  br label %block_end72

block_end72:                                      ; preds = %else71
  br label %merge61

merge77:                                          ; preds = %block_end81, %then78
  %horiz_timer82 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %horiz_timer83 = load i32, i32* %horiz_timer82
  %tmp84 = icmp sgt i32 %horiz_timer83, 0
  br i1 %tmp84, label %then86, label %else90

then78:                                           ; preds = %merge61
  %this79 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveDown"(%objref %this79)
  br label %merge77

else80:                                           ; preds = %merge61
  br label %block_end81

block_end81:                                      ; preds = %else80
  br label %merge77

merge85:                                          ; preds = %block_end91, %then86
  %hard_drop92 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %hard_drop93 = load i32, i32* %hard_drop92
  %tmp94 = icmp sgt i32 %hard_drop93, 0
  br i1 %tmp94, label %then96, label %else100

then86:                                           ; preds = %merge77
  %horiz_timer87 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %le88 = load i32, i32* %horiz_timer87
  %Asn89 = sub i32 %le88, 1
  store i32 %Asn89, i32* %horiz_timer87
  %6 = load i32, i32* %horiz_timer87
  br label %merge85

else90:                                           ; preds = %merge77
  br label %block_end91

block_end91:                                      ; preds = %else90
  br label %merge85

merge95:                                          ; preds = %block_end101, %then96
  br label %block_end

then96:                                           ; preds = %merge85
  %hard_drop97 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %le98 = load i32, i32* %hard_drop97
  %Asn99 = sub i32 %le98, 1
  store i32 %Asn99, i32* %hard_drop97
  %7 = load i32, i32* %hard_drop97
  br label %merge95

else100:                                          ; preds = %merge85
  br label %block_end101

block_end101:                                     ; preds = %else100
  br label %merge95
}

define void @"object::Piece.event.create"(%objref %this, %objref %b) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %b2 = alloca %objref
  store %objref %b, %objref* %b2
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  store i32 0, i32* %drop_points
  %0 = load i32, i32* %drop_points
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %b3 = load %objref, %objref* %b2
  store %objref %b3, %objref* %board
  %1 = load %objref, %objref* %board
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %current_speed_result = call i32 @"function::current_speed"()
  store i32 %current_speed_result, i32* %curr_timer
  %2 = load i32, i32* %curr_timer
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  store i1 false, i1* %active
  %3 = load i1, i1* %active
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  store i32 1, i32* %hard_drop
  %4 = load i32, i32* %hard_drop
  %piece_type_x = alloca i32
  %irandom_result = call i32 @"function:file-../../lib/math.mg::irandom"(i32 3)
  store i32 %irandom_result, i32* %piece_type_x
  %piece_type_y = alloca i32
  %irandom_result4 = call i32 @"function:file-../../lib/math.mg::irandom"(i32 10)
  store i32 %irandom_result4, i32* %piece_type_y
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %irandom_result5 = call i32 @"function:file-../../lib/math.mg::irandom"(i32 7)
  store i32 %irandom_result5, i32* %piece_type
  %5 = load i32, i32* %piece_type
  %k = alloca i32
  store i32 0, i32* %k
  %y = alloca i32
  store i32 0, i32* %y
  br label %while

block_end:                                        ; preds = %block_end6
  ret void

block_end6:                                       ; preds = %merge
  br label %block_end

while:                                            ; preds = %block_end8, %entry
  %y7 = load i32, i32* %y
  %tmp = icmp slt i32 %y7, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %x = alloca i32
  store i32 0, i32* %x
  br label %while10

merge:                                            ; preds = %while
  br label %block_end6

block_end8:                                       ; preds = %block_end9
  br label %while

block_end9:                                       ; preds = %merge12
  %le44 = load i32, i32* %y
  %Asn45 = add i32 %le44, 1
  store i32 %Asn45, i32* %y
  %6 = load i32, i32* %y
  br label %block_end8

while10:                                          ; preds = %block_end15, %while_body
  %x13 = load i32, i32* %x
  %tmp14 = icmp slt i32 %x13, 3
  br i1 %tmp14, label %while_body11, label %merge12

while_body11:                                     ; preds = %while10
  %x16 = load i32, i32* %x
  %y17 = load i32, i32* %y
  %piece_type18 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %piece_type19 = load i32, i32* %piece_type18
  %possible_pieces = load [7 x [4 x [3 x i1]]], [7 x [4 x [3 x i1]]]* @"variable::possible_pieces"
  %arr = alloca [7 x [4 x [3 x i1]]]
  store [7 x [4 x [3 x i1]]] %possible_pieces, [7 x [4 x [3 x i1]]]* %arr
  %7 = getelementptr [7 x [4 x [3 x i1]]], [7 x [4 x [3 x i1]]]* %arr, i32 0, i32 %piece_type19
  %subscript = load [4 x [3 x i1]], [4 x [3 x i1]]* %7
  %arr20 = alloca [4 x [3 x i1]]
  store [4 x [3 x i1]] %subscript, [4 x [3 x i1]]* %arr20
  %8 = getelementptr [4 x [3 x i1]], [4 x [3 x i1]]* %arr20, i32 0, i32 %y17
  %subscript21 = load [3 x i1], [3 x i1]* %8
  %arr22 = alloca [3 x i1]
  store [3 x i1] %subscript21, [3 x i1]* %arr22
  %9 = getelementptr [3 x i1], [3 x i1]* %arr22, i32 0, i32 %x16
  %subscript23 = load i1, i1* %9
  br i1 %subscript23, label %then, label %else

merge12:                                          ; preds = %while10
  br label %block_end9

block_end15:                                      ; preds = %merge24
  br label %while10

merge24:                                          ; preds = %block_end41, %block_end25
  %le42 = load i32, i32* %x
  %Asn43 = add i32 %le42, 1
  store i32 %Asn43, i32* %x
  %10 = load i32, i32* %x
  br label %block_end15

then:                                             ; preds = %while_body11
  %k26 = load i32, i32* %k
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %subscript27 = getelementptr [4 x %objref], [4 x %objref]* %blocks, i32 0, i32 %k26
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%Block* getelementptr (%Block, %Block* null, i32 1) to i32))
  %Block = bitcast i8* %malloccall to %Block*
  store %Block zeroinitializer, %Block* %Block
  %Block_gen = bitcast %Block* %Block to %gameobj*
  %Block_objnode = getelementptr inbounds %Block, %Block* %Block, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %Block_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %Block_objnode, %node* @"node.object::Block.head")
  %Block_parent = getelementptr inbounds %Block, %Block* %Block, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %Block_parent, i32 0, i32 1
  %marker28 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker28
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %Block_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %11 = getelementptr inbounds %gameobj, %gameobj* %Block_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Block.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %11
  %12 = getelementptr inbounds %gameobj, %gameobj* %Block_gen, i32 0, i32 2
  store i64 %new_id, i64* %12
  %13 = insertvalue %objref undef, i64 %new_id, 0
  %14 = insertvalue %objref %13, %gameobj* %Block_gen, 1
  %x29 = load i32, i32* %x
  %tmp30 = sub i32 %x29, 1
  %y31 = load i32, i32* %y
  %tmp32 = sub i32 %y31, 1
  %this33 = load %objref, %objref* %this1
  call void @"object::Block.event.create"(%objref %14, i32 %tmp30, i32 %tmp32, %objref %this33)
  store %objref %14, %objref* %subscript27
  %15 = load %objref, %objref* %subscript27
  %k34 = load i32, i32* %k
  %blocks35 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks36 = load [4 x %objref], [4 x %objref]* %blocks35
  %arr37 = alloca [4 x %objref]
  store [4 x %objref] %blocks36, [4 x %objref]* %arr37
  %16 = getelementptr [4 x %objref], [4 x %objref]* %arr37, i32 0, i32 %k34
  %subscript38 = load %objref, %objref* %16
  %piece_type_x39 = load i32, i32* %piece_type_x
  %piece_type_y40 = load i32, i32* %piece_type_y
  call void @"object::Block.function.setType"(%objref %subscript38, i32 %piece_type_x39, i32 %piece_type_y40)
  %le = load i32, i32* %k
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %k
  %17 = load i32, i32* %k
  br label %block_end25

block_end25:                                      ; preds = %then
  br label %merge24

else:                                             ; preds = %while_body11
  br label %block_end41

block_end41:                                      ; preds = %else
  br label %merge24
}

define void @"delete_%Piece = type { %gameobj, %node, %objref, i32, i32, i1, i32, i32, i32, i32, i32, %objref, [4 x %objref] }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Piece*
  %objnode = getelementptr inbounds %Piece, %Piece* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Piece, %Piece* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define void @"object::Piece.function.settlePosition"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %merge29
  ret void

block_end2:                                       ; preds = %merge
  %drop = load %sfSound*, %sfSound** @"variable::snds::drop"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %drop)
  %board16 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %board17 = load %objref, %objref* %board16
  call void @"object::Board.function.checkRows"(%objref %board17)
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  store i1 false, i1* %active
  %0 = load i1, i1* %active
  %this18 = load %objref, %objref* %this1
  %objptr19 = extractvalue %objref %this18, 1
  %1 = bitcast %gameobj* %objptr19 to { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }**
  %tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %1
  %eventptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 3
  %event = load void (%objref)*, void (%objref)** %eventptr
  %eventptr20 = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 1
  %event21 = load void (%objref)*, void (%objref)** %eventptr20
  call void %event21(%objref %this18)
  call void %event(%objref %this18)
  %id = getelementptr inbounds %gameobj, %gameobj* %objptr19, i32 0, i32 2
  store i64 0, i64* %id
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen22 = extractvalue %objref %score_count, 1
  %objptr23 = bitcast %gameobj* %objptr_gen22 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 3
  %le24 = load i32, i32* %n
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %drop_points25 = load i32, i32* %drop_points
  %Asn26 = add i32 %le24, %drop_points25
  store i32 %Asn26, i32* %n
  %2 = load i32, i32* %n
  %tail = alloca %node
  %marker = getelementptr inbounds %node, %node* %tail, i32 0, i32 2
  store i1 false, i1* %marker
  %curr_ptr = alloca %node*
  %next_ptr = alloca %node*
  call void @list_add(%node* %tail, %node* @"node.object::game_over.head")
  store %node* @"node.object::game_over.head", %node** %curr_ptr
  %3 = load %node*, %node** getelementptr inbounds (%node, %node* @"node.object::game_over.head", i32 0, i32 1)
  store %node* %3, %node** %next_ptr
  br label %while27

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i6 = load i32, i32* %i
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks7 = load [4 x %objref], [4 x %objref]* %blocks
  %arr = alloca [4 x %objref]
  store [4 x %objref] %blocks7, [4 x %objref]* %arr
  %4 = getelementptr [4 x %objref], [4 x %objref]* %arr, i32 0, i32 %i6
  %subscript = load %objref, %objref* %4
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %board8 = load %objref, %objref* %board
  call void @"object::Block.function.settlePosition"(%objref %subscript, %objref %board8)
  %i9 = load i32, i32* %i
  %blocks10 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks11 = load [4 x %objref], [4 x %objref]* %blocks10
  %arr12 = alloca [4 x %objref]
  store [4 x %objref] %blocks11, [4 x %objref]* %arr12
  %5 = getelementptr [4 x %objref], [4 x %objref]* %arr12, i32 0, i32 %i9
  %subscript13 = load %objref, %objref* %5
  %objptr_gen14 = extractvalue %objref %subscript13, 1
  %objptr15 = bitcast %gameobj* %objptr_gen14 to %Block*
  %piece = getelementptr inbounds %Block, %Block* %objptr15, i32 0, i32 2
  store %objref zeroinitializer, %objref* %piece
  %6 = load %objref, %objref* %piece
  br label %block_end5

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %block_end5
  br label %while

block_end5:                                       ; preds = %while_body
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %7 = load i32, i32* %i
  br label %block_end4

while27:                                          ; preds = %merge32, %block_end2
  %curr = load %node*, %node** %next_ptr
  %8 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next = load %node*, %node** %8
  %9 = ptrtoint %node* %curr to i64
  %10 = ptrtoint %node* %next to i64
  %11 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next, %node** %next_ptr
  %cont = icmp ne %node* %curr, @"node.object::game_over.head"
  br i1 %cont, label %while_body28, label %merge29

while_body28:                                     ; preds = %while27
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker30 = load i1, i1* %markerptr
  %cont31 = icmp eq i1 %marker30, true
  br i1 %cont31, label %then, label %else38

merge29:                                          ; preds = %while27
  call void @list_rem(%node* %tail)
  %next43 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %next44 = load %objref, %objref* %next43
  call void @"object::Piece.function.activate"(%objref %next44)
  %drop45 = load %sfSound*, %sfSound** @"variable::snds::drop"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %drop45)
  br label %block_end

merge32:                                          ; preds = %merge40, %merge34
  br label %while27

then:                                             ; preds = %while_body28
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%game_over, %game_over* null, i32 0, i32 1) to i64)
  %game_over = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %game_over, i32 0, i32 2
  %id33 = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id33, 0
  br i1 %is_removed, label %then35, label %else

merge34:                                          ; preds = %else, %block_end37
  br label %merge32

then35:                                           ; preds = %then
  %12 = getelementptr inbounds %gameobj, %gameobj* %game_over, i32 0, i32 2
  %id36 = load i64, i64* %12
  %13 = insertvalue %objref undef, i64 %id36, 0
  %14 = insertvalue %objref %13, %gameobj* %game_over, 1
  %ref = alloca %objref
  store %objref %14, %objref* %ref
  ret void

block_end37:                                      ; preds = %postret
  br label %merge34

postret:                                          ; No predecessors!
  br label %block_end37

else:                                             ; preds = %then
  br label %merge34

else38:                                           ; preds = %while_body28
  %cont39 = icmp eq %node* %curr, %tail
  br i1 %cont39, label %then41, label %else42

merge40:                                          ; preds = %else42, %then41
  br label %merge32

then41:                                           ; preds = %else38
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @"node.object::game_over.head")
  br label %merge40

else42:                                           ; preds = %else38
  br label %merge40
}

define void @"object::Piece.function.moveDown"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %current_speed_result = call i32 @"function::current_speed"()
  store i32 %current_speed_result, i32* %curr_timer
  %0 = load i32, i32* %curr_timer
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %le = load i32, i32* %y
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %y
  %1 = load i32, i32* %y
  %this2 = load %objref, %objref* %this1
  %isColliding_result = call i1 @"object::Piece.function.isColliding"(%objref %this2)
  br i1 %isColliding_result, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end8, %block_end3
  br label %block_end

then:                                             ; preds = %entry
  %y4 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %le5 = load i32, i32* %y4
  %Asn6 = sub i32 %le5, 1
  store i32 %Asn6, i32* %y4
  %2 = load i32, i32* %y4
  %this7 = load %objref, %objref* %this1
  call void @"object::Piece.function.settlePosition"(%objref %this7)
  br label %block_end3

block_end3:                                       ; preds = %then
  br label %merge

else:                                             ; preds = %entry
  br label %block_end8

block_end8:                                       ; preds = %else
  br label %merge
}

define void @"object::Piece.function.moveRight"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %le = load i32, i32* %x
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %x
  %0 = load i32, i32* %x
  %this2 = load %objref, %objref* %this1
  %isColliding_result = call i1 @"object::Piece.function.isColliding"(%objref %this2)
  br i1 %isColliding_result, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %else, %then
  br label %block_end

then:                                             ; preds = %entry
  %x3 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %le4 = load i32, i32* %x3
  %Asn5 = sub i32 %le4, 1
  store i32 %Asn5, i32* %x3
  %1 = load i32, i32* %x3
  br label %merge

else:                                             ; preds = %entry
  %move = load %sfSound*, %sfSound** @"variable::snds::move"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %move)
  br label %merge
}

define void @"object::Piece.function.moveLeft"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %le = load i32, i32* %x
  %Asn = sub i32 %le, 1
  store i32 %Asn, i32* %x
  %0 = load i32, i32* %x
  %this2 = load %objref, %objref* %this1
  %isColliding_result = call i1 @"object::Piece.function.isColliding"(%objref %this2)
  br i1 %isColliding_result, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %else, %then
  br label %block_end

then:                                             ; preds = %entry
  %x3 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %le4 = load i32, i32* %x3
  %Asn5 = add i32 %le4, 1
  store i32 %Asn5, i32* %x3
  %1 = load i32, i32* %x3
  br label %merge

else:                                             ; preds = %entry
  %move = load %sfSound*, %sfSound** @"variable::snds::move"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %move)
  br label %merge
}

define void @"object::Piece.function.rotateRight"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %merge8
  ret void

block_end2:                                       ; preds = %merge
  %this7 = load %objref, %objref* %this1
  %isColliding_result = call i1 @"object::Piece.function.isColliding"(%objref %this7)
  br i1 %isColliding_result, label %then, label %else

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i5 = load i32, i32* %i
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks6 = load [4 x %objref], [4 x %objref]* %blocks
  %arr = alloca [4 x %objref]
  store [4 x %objref] %blocks6, [4 x %objref]* %arr
  %0 = getelementptr [4 x %objref], [4 x %objref]* %arr, i32 0, i32 %i5
  %subscript = load %objref, %objref* %0
  call void @"object::Block.function.rotateRight"(%objref %subscript)
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %1 = load i32, i32* %i
  br label %block_end4

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %while_body
  br label %while

merge8:                                           ; preds = %else, %block_end9
  br label %block_end

then:                                             ; preds = %block_end2
  %i10 = alloca i32
  store i32 0, i32* %i10
  br label %while11

block_end9:                                       ; preds = %merge13
  br label %merge8

while11:                                          ; preds = %block_end16, %then
  %i14 = load i32, i32* %i10
  %tmp15 = icmp slt i32 %i14, 4
  br i1 %tmp15, label %while_body12, label %merge13

while_body12:                                     ; preds = %while11
  %i17 = load i32, i32* %i10
  %blocks18 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks19 = load [4 x %objref], [4 x %objref]* %blocks18
  %arr20 = alloca [4 x %objref]
  store [4 x %objref] %blocks19, [4 x %objref]* %arr20
  %2 = getelementptr [4 x %objref], [4 x %objref]* %arr20, i32 0, i32 %i17
  %subscript21 = load %objref, %objref* %2
  call void @"object::Block.function.rotateLeft"(%objref %subscript21)
  %le22 = load i32, i32* %i10
  %Asn23 = add i32 %le22, 1
  store i32 %Asn23, i32* %i10
  %3 = load i32, i32* %i10
  br label %block_end16

merge13:                                          ; preds = %while11
  br label %block_end9

block_end16:                                      ; preds = %while_body12
  br label %while11

else:                                             ; preds = %block_end2
  %turn = load %sfSound*, %sfSound** @"variable::snds::turn"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %turn)
  br label %merge8
}

define void @"object::Piece.function.rotateLeft"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %merge8
  ret void

block_end2:                                       ; preds = %merge
  %this7 = load %objref, %objref* %this1
  %isColliding_result = call i1 @"object::Piece.function.isColliding"(%objref %this7)
  br i1 %isColliding_result, label %then, label %else

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i5 = load i32, i32* %i
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks6 = load [4 x %objref], [4 x %objref]* %blocks
  %arr = alloca [4 x %objref]
  store [4 x %objref] %blocks6, [4 x %objref]* %arr
  %0 = getelementptr [4 x %objref], [4 x %objref]* %arr, i32 0, i32 %i5
  %subscript = load %objref, %objref* %0
  call void @"object::Block.function.rotateLeft"(%objref %subscript)
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %1 = load i32, i32* %i
  br label %block_end4

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %while_body
  br label %while

merge8:                                           ; preds = %else, %block_end9
  br label %block_end

then:                                             ; preds = %block_end2
  %i10 = alloca i32
  store i32 0, i32* %i10
  br label %while11

block_end9:                                       ; preds = %merge13
  br label %merge8

while11:                                          ; preds = %block_end16, %then
  %i14 = load i32, i32* %i10
  %tmp15 = icmp slt i32 %i14, 4
  br i1 %tmp15, label %while_body12, label %merge13

while_body12:                                     ; preds = %while11
  %i17 = load i32, i32* %i10
  %blocks18 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks19 = load [4 x %objref], [4 x %objref]* %blocks18
  %arr20 = alloca [4 x %objref]
  store [4 x %objref] %blocks19, [4 x %objref]* %arr20
  %2 = getelementptr [4 x %objref], [4 x %objref]* %arr20, i32 0, i32 %i17
  %subscript21 = load %objref, %objref* %2
  call void @"object::Block.function.rotateRight"(%objref %subscript21)
  %le22 = load i32, i32* %i10
  %Asn23 = add i32 %le22, 1
  store i32 %Asn23, i32* %i10
  %3 = load i32, i32* %i10
  br label %block_end16

merge13:                                          ; preds = %while11
  br label %block_end9

block_end16:                                      ; preds = %while_body12
  br label %while11

else:                                             ; preds = %block_end2
  %turn = load %sfSound*, %sfSound** @"variable::snds::turn"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %turn)
  br label %merge8
}

define i1 @"object::Piece.function.isColliding"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %postret27
  ret i1 false

block_end2:                                       ; preds = %merge
  ret i1 false

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %board5 = load %objref, %objref* %board
  %i6 = load i32, i32* %i
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks7 = load [4 x %objref], [4 x %objref]* %blocks
  %arr = alloca [4 x %objref]
  store [4 x %objref] %blocks7, [4 x %objref]* %arr
  %0 = getelementptr [4 x %objref], [4 x %objref]* %arr, i32 0, i32 %i6
  %subscript = load %objref, %objref* %0
  %objptr_gen8 = extractvalue %objref %subscript, 1
  %objptr9 = bitcast %gameobj* %objptr_gen8 to %Block*
  %x = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 8
  %x10 = load i32, i32* %x
  %x11 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %x12 = load i32, i32* %x11
  %tmp13 = add i32 %x10, %x12
  %i14 = load i32, i32* %i
  %blocks15 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %blocks16 = load [4 x %objref], [4 x %objref]* %blocks15
  %arr17 = alloca [4 x %objref]
  store [4 x %objref] %blocks16, [4 x %objref]* %arr17
  %1 = getelementptr [4 x %objref], [4 x %objref]* %arr17, i32 0, i32 %i14
  %subscript18 = load %objref, %objref* %1
  %objptr_gen19 = extractvalue %objref %subscript18, 1
  %objptr20 = bitcast %gameobj* %objptr_gen19 to %Block*
  %y = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 7
  %y21 = load i32, i32* %y
  %y22 = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %y23 = load i32, i32* %y22
  %tmp24 = add i32 %y21, %y23
  %occupied_result = call i1 @"object::Board.function.occupied"(%objref %board5, i32 %tmp13, i32 %tmp24)
  br i1 %occupied_result, label %then, label %else

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %merge25
  br label %while

merge25:                                          ; preds = %block_end26, %postret
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %2 = load i32, i32* %i
  br label %block_end4

then:                                             ; preds = %while_body
  ret i1 true

postret:                                          ; No predecessors!
  br label %merge25

else:                                             ; preds = %while_body
  br label %block_end26

block_end26:                                      ; preds = %else
  br label %merge25

postret27:                                        ; No predecessors!
  br label %block_end
}

define void @"object::Piece.function.activate"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %piece_type2 = load i32, i32* %piece_type
  %piece_counts = load [7 x %objref], [7 x %objref]* @"variable::piece_counts"
  %arr = alloca [7 x %objref]
  store [7 x %objref] %piece_counts, [7 x %objref]* %arr
  %0 = getelementptr [7 x %objref], [7 x %objref]* %arr, i32 0, i32 %piece_type2
  %subscript = load %objref, %objref* %0
  %objptr_gen3 = extractvalue %objref %subscript, 1
  %objptr4 = bitcast %gameobj* %objptr_gen3 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 3
  %le = load i32, i32* %n
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %n
  %1 = load i32, i32* %n
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  store i1 true, i1* %active
  %2 = load i1, i1* %active
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%Piece* getelementptr (%Piece, %Piece* null, i32 1) to i32))
  %Piece = bitcast i8* %malloccall to %Piece*
  store %Piece zeroinitializer, %Piece* %Piece
  %Piece_gen = bitcast %Piece* %Piece to %gameobj*
  %Piece_objnode = getelementptr inbounds %Piece, %Piece* %Piece, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %Piece_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %Piece_objnode, %node* @"node.object::Piece.head")
  %Piece_parent = getelementptr inbounds %Piece, %Piece* %Piece, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %Piece_parent, i32 0, i32 1
  %marker5 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker5
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %Piece_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %3 = getelementptr inbounds %gameobj, %gameobj* %Piece_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Piece.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %3
  %4 = getelementptr inbounds %gameobj, %gameobj* %Piece_gen, i32 0, i32 2
  store i64 %new_id, i64* %4
  %5 = insertvalue %objref undef, i64 %new_id, 0
  %6 = insertvalue %objref %5, %gameobj* %Piece_gen, 1
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %board6 = load %objref, %objref* %board
  call void @"object::Piece.event.create"(%objref %6, %objref %board6)
  store %objref %6, %objref* %next
  %7 = load %objref, %objref* %next
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  store i32 5, i32* %x
  %8 = load i32, i32* %x
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  store i32 1, i32* %y
  %9 = load i32, i32* %y
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::Board.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Board*
  %y = alloca i32
  store i32 0, i32* %y
  br label %while

block_end:                                        ; preds = %block_end2
  ret void

block_end2:                                       ; preds = %merge
  br label %block_end

while:                                            ; preds = %block_end4, %entry
  %y3 = load i32, i32* %y
  %board_height = load i32, i32* @"variable::board_height"
  %tmp = icmp slt i32 %y3, %board_height
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %x = alloca i32
  store i32 0, i32* %x
  br label %while6

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %block_end5
  br label %while

block_end5:                                       ; preds = %merge8
  %le15 = load i32, i32* %y
  %Asn16 = add i32 %le15, 1
  store i32 %Asn16, i32* %y
  %0 = load i32, i32* %y
  br label %block_end4

while6:                                           ; preds = %block_end11, %while_body
  %x9 = load i32, i32* %x
  %board_width = load i32, i32* @"variable::board_width"
  %tmp10 = icmp slt i32 %x9, %board_width
  br i1 %tmp10, label %while_body7, label %merge8

while_body7:                                      ; preds = %while6
  %x12 = load i32, i32* %x
  %y13 = load i32, i32* %y
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %subscript = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces, i32 0, i32 %y13
  %subscript14 = getelementptr [10 x %objref], [10 x %objref]* %subscript, i32 0, i32 %x12
  store %objref zeroinitializer, %objref* %subscript14
  %1 = load %objref, %objref* %subscript14
  %le = load i32, i32* %x
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %x
  %2 = load i32, i32* %x
  br label %block_end11

merge8:                                           ; preds = %while6
  br label %block_end5

block_end11:                                      ; preds = %while_body7
  br label %while6
}

define void @"delete_%Board = type { %gameobj, %node, [24 x [10 x %objref]] }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Board*
  %objnode = getelementptr inbounds %Board, %Board* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Board, %Board* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
}

define i1 @"object::Board.function.occupied"(%objref %this, i32 %x, i32 %y) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca i32
  store i32 %x, i32* %x2
  %y3 = alloca i32
  store i32 %y, i32* %y3
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Board*
  %x4 = load i32, i32* %x2
  %tmp = icmp slt i32 %x4, 0
  %x5 = load i32, i32* %x2
  %board_width = load i32, i32* @"variable::board_width"
  %tmp6 = icmp sge i32 %x5, %board_width
  %tmp7 = or i1 %tmp, %tmp6
  %y8 = load i32, i32* %y3
  %board_height = load i32, i32* @"variable::board_height"
  %tmp9 = icmp sge i32 %y8, %board_height
  %tmp10 = or i1 %tmp7, %tmp9
  br i1 %tmp10, label %then, label %else

block_end:                                        ; preds = %postret30
  ret i1 false

merge:                                            ; preds = %block_end11, %postret
  %y12 = load i32, i32* %y3
  %tmp13 = icmp slt i32 %y12, 0
  br i1 %tmp13, label %then15, label %else17

then:                                             ; preds = %entry
  ret i1 true

postret:                                          ; No predecessors!
  br label %merge

else:                                             ; preds = %entry
  br label %block_end11

block_end11:                                      ; preds = %else
  br label %merge

merge14:                                          ; preds = %block_end18, %postret16
  %x19 = load i32, i32* %x2
  %y20 = load i32, i32* %y3
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %pieces21 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces
  %arr = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces21, [24 x [10 x %objref]]* %arr
  %0 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr, i32 0, i32 %y20
  %subscript = load [10 x %objref], [10 x %objref]* %0
  %arr22 = alloca [10 x %objref]
  store [10 x %objref] %subscript, [10 x %objref]* %arr22
  %1 = getelementptr [10 x %objref], [10 x %objref]* %arr22, i32 0, i32 %x19
  %subscript23 = load %objref, %objref* %1
  %tmp_lid = extractvalue %objref %subscript23, 0
  %tmp24 = icmp ne i64 %tmp_lid, 0
  br i1 %tmp24, label %then26, label %else28

then15:                                           ; preds = %merge
  ret i1 false

postret16:                                        ; No predecessors!
  br label %merge14

else17:                                           ; preds = %merge
  br label %block_end18

block_end18:                                      ; preds = %else17
  br label %merge14

merge25:                                          ; preds = %block_end29, %postret27
  ret i1 false

then26:                                           ; preds = %merge14
  ret i1 true

postret27:                                        ; No predecessors!
  br label %merge25

else28:                                           ; preds = %merge14
  br label %block_end29

block_end29:                                      ; preds = %else28
  br label %merge25

postret30:                                        ; No predecessors!
  br label %block_end
}

define i1 @"object::Board.function.checkRow"(%objref %this, i32 %r) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %r2 = alloca i32
  store i32 %r, i32* %r2
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Board*
  %x = alloca i32
  store i32 0, i32* %x
  br label %while

block_end:                                        ; preds = %postret158
  ret i1 false

block_end3:                                       ; preds = %merge
  %x15 = alloca i32
  store i32 0, i32* %x15
  br label %while16

while:                                            ; preds = %block_end5, %entry
  %x4 = load i32, i32* %x
  %board_width = load i32, i32* @"variable::board_width"
  %tmp = icmp slt i32 %x4, %board_width
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %x6 = load i32, i32* %x
  %r7 = load i32, i32* %r2
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %pieces8 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces
  %arr = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces8, [24 x [10 x %objref]]* %arr
  %0 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr, i32 0, i32 %r7
  %subscript = load [10 x %objref], [10 x %objref]* %0
  %arr9 = alloca [10 x %objref]
  store [10 x %objref] %subscript, [10 x %objref]* %arr9
  %1 = getelementptr [10 x %objref], [10 x %objref]* %arr9, i32 0, i32 %x6
  %subscript10 = load %objref, %objref* %1
  %tmp_lid = extractvalue %objref %subscript10, 0
  %tmp11 = icmp eq i64 %tmp_lid, 0
  br i1 %tmp11, label %then, label %else

merge:                                            ; preds = %while
  br label %block_end3

block_end5:                                       ; preds = %merge12
  br label %while

merge12:                                          ; preds = %block_end13, %postret
  %le = load i32, i32* %x
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %x
  %2 = load i32, i32* %x
  br label %block_end5

then:                                             ; preds = %while_body
  ret i1 false

postret:                                          ; No predecessors!
  br label %merge12

else:                                             ; preds = %while_body
  br label %block_end13

block_end13:                                      ; preds = %else
  br label %merge12

block_end14:                                      ; preds = %merge18
  %y = alloca i32
  %r37 = load i32, i32* %r2
  store i32 %r37, i32* %y
  br label %while38

while16:                                          ; preds = %block_end22, %block_end3
  %x19 = load i32, i32* %x15
  %board_width20 = load i32, i32* @"variable::board_width"
  %tmp21 = icmp slt i32 %x19, %board_width20
  br i1 %tmp21, label %while_body17, label %merge18

while_body17:                                     ; preds = %while16
  %x23 = load i32, i32* %x15
  %r24 = load i32, i32* %r2
  %pieces25 = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %pieces26 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces25
  %arr27 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces26, [24 x [10 x %objref]]* %arr27
  %3 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr27, i32 0, i32 %r24
  %subscript28 = load [10 x %objref], [10 x %objref]* %3
  %arr29 = alloca [10 x %objref]
  store [10 x %objref] %subscript28, [10 x %objref]* %arr29
  %4 = getelementptr [10 x %objref], [10 x %objref]* %arr29, i32 0, i32 %x23
  %subscript30 = load %objref, %objref* %4
  %objptr31 = extractvalue %objref %subscript30, 1
  %5 = bitcast %gameobj* %objptr31 to { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }**
  %tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %5
  %eventptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 3
  %event = load void (%objref)*, void (%objref)** %eventptr
  %eventptr32 = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 1
  %event33 = load void (%objref)*, void (%objref)** %eventptr32
  call void %event33(%objref %subscript30)
  call void %event(%objref %subscript30)
  %id = getelementptr inbounds %gameobj, %gameobj* %objptr31, i32 0, i32 2
  store i64 0, i64* %id
  %le34 = load i32, i32* %x15
  %Asn35 = add i32 %le34, 1
  store i32 %Asn35, i32* %x15
  %6 = load i32, i32* %x15
  br label %block_end22

merge18:                                          ; preds = %while16
  br label %block_end14

block_end22:                                      ; preds = %while_body17
  br label %while16

block_end36:                                      ; preds = %merge40
  %x100 = alloca i32
  store i32 0, i32* %x100
  br label %while101

while38:                                          ; preds = %block_end43, %block_end14
  %y41 = load i32, i32* %y
  %tmp42 = icmp sgt i32 %y41, 0
  br i1 %tmp42, label %while_body39, label %merge40

while_body39:                                     ; preds = %while38
  %x45 = alloca i32
  store i32 0, i32* %x45
  br label %while46

merge40:                                          ; preds = %while38
  br label %block_end36

block_end43:                                      ; preds = %block_end44
  br label %while38

block_end44:                                      ; preds = %merge48
  %le97 = load i32, i32* %y
  %Asn98 = sub i32 %le97, 1
  store i32 %Asn98, i32* %y
  %7 = load i32, i32* %y
  br label %block_end43

while46:                                          ; preds = %block_end52, %while_body39
  %x49 = load i32, i32* %x45
  %board_width50 = load i32, i32* @"variable::board_width"
  %tmp51 = icmp slt i32 %x49, %board_width50
  br i1 %tmp51, label %while_body47, label %merge48

while_body47:                                     ; preds = %while46
  %x54 = load i32, i32* %x45
  %y55 = load i32, i32* %y
  %pieces56 = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %subscript57 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces56, i32 0, i32 %y55
  %subscript58 = getelementptr [10 x %objref], [10 x %objref]* %subscript57, i32 0, i32 %x54
  %x59 = load i32, i32* %x45
  %y60 = load i32, i32* %y
  %tmp61 = sub i32 %y60, 1
  %pieces62 = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %pieces63 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces62
  %arr64 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces63, [24 x [10 x %objref]]* %arr64
  %8 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr64, i32 0, i32 %tmp61
  %subscript65 = load [10 x %objref], [10 x %objref]* %8
  %arr66 = alloca [10 x %objref]
  store [10 x %objref] %subscript65, [10 x %objref]* %arr66
  %9 = getelementptr [10 x %objref], [10 x %objref]* %arr66, i32 0, i32 %x59
  %subscript67 = load %objref, %objref* %9
  store %objref %subscript67, %objref* %subscript58
  %10 = load %objref, %objref* %subscript58
  %x68 = load i32, i32* %x45
  %y69 = load i32, i32* %y
  %pieces70 = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %pieces71 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces70
  %arr72 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces71, [24 x [10 x %objref]]* %arr72
  %11 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr72, i32 0, i32 %y69
  %subscript73 = load [10 x %objref], [10 x %objref]* %11
  %arr74 = alloca [10 x %objref]
  store [10 x %objref] %subscript73, [10 x %objref]* %arr74
  %12 = getelementptr [10 x %objref], [10 x %objref]* %arr74, i32 0, i32 %x68
  %subscript75 = load %objref, %objref* %12
  %tmp_lid76 = extractvalue %objref %subscript75, 0
  %tmp77 = icmp ne i64 %tmp_lid76, 0
  br i1 %tmp77, label %then79, label %else93

merge48:                                          ; preds = %while46
  br label %block_end44

block_end52:                                      ; preds = %block_end53
  br label %while46

block_end53:                                      ; preds = %merge78
  %le95 = load i32, i32* %x45
  %Asn96 = add i32 %le95, 1
  store i32 %Asn96, i32* %x45
  %13 = load i32, i32* %x45
  br label %block_end52

merge78:                                          ; preds = %block_end94, %then79
  br label %block_end53

then79:                                           ; preds = %while_body47
  %x80 = load i32, i32* %x45
  %y81 = load i32, i32* %y
  %pieces82 = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %pieces83 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces82
  %arr84 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces83, [24 x [10 x %objref]]* %arr84
  %14 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr84, i32 0, i32 %y81
  %subscript85 = load [10 x %objref], [10 x %objref]* %14
  %arr86 = alloca [10 x %objref]
  store [10 x %objref] %subscript85, [10 x %objref]* %arr86
  %15 = getelementptr [10 x %objref], [10 x %objref]* %arr86, i32 0, i32 %x80
  %subscript87 = load %objref, %objref* %15
  %objptr_gen88 = extractvalue %objref %subscript87, 1
  %objptr89 = bitcast %gameobj* %objptr_gen88 to %Block*
  %y90 = getelementptr inbounds %Block, %Block* %objptr89, i32 0, i32 7
  %le91 = load i32, i32* %y90
  %Asn92 = add i32 %le91, 1
  store i32 %Asn92, i32* %y90
  %16 = load i32, i32* %y90
  br label %merge78

else93:                                           ; preds = %while_body47
  br label %block_end94

block_end94:                                      ; preds = %else93
  br label %merge78

block_end99:                                      ; preds = %merge103
  %lines_count = load %objref, %objref* @"variable::lines_count"
  %objptr_gen114 = extractvalue %objref %lines_count, 1
  %objptr115 = bitcast %gameobj* %objptr_gen114 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr115, i32 0, i32 3
  %le116 = load i32, i32* %n
  %Asn117 = add i32 %le116, 1
  store i32 %Asn117, i32* %n
  %17 = load i32, i32* %n
  %lines_count118 = load %objref, %objref* @"variable::lines_count"
  %objptr_gen119 = extractvalue %objref %lines_count118, 1
  %objptr120 = bitcast %gameobj* %objptr_gen119 to %Draw*
  %n121 = getelementptr inbounds %Draw, %Draw* %objptr120, i32 0, i32 3
  %n122 = load i32, i32* %n121
  %tmp123 = sdiv i32 %n122, 5
  %level_count = load %objref, %objref* @"variable::level_count"
  %objptr_gen124 = extractvalue %objref %level_count, 1
  %objptr125 = bitcast %gameobj* %objptr_gen124 to %Draw*
  %n126 = getelementptr inbounds %Draw, %Draw* %objptr125, i32 0, i32 3
  %n127 = load i32, i32* %n126
  %tmp128 = icmp sgt i32 %tmp123, %n127
  br i1 %tmp128, label %then130, label %else142

while101:                                         ; preds = %block_end107, %block_end36
  %x104 = load i32, i32* %x100
  %board_width105 = load i32, i32* @"variable::board_width"
  %tmp106 = icmp slt i32 %x104, %board_width105
  br i1 %tmp106, label %while_body102, label %merge103

while_body102:                                    ; preds = %while101
  %x108 = load i32, i32* %x100
  %pieces109 = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %subscript110 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces109, i32 0, i32 0
  %subscript111 = getelementptr [10 x %objref], [10 x %objref]* %subscript110, i32 0, i32 %x108
  store %objref zeroinitializer, %objref* %subscript111
  %18 = load %objref, %objref* %subscript111
  %le112 = load i32, i32* %x100
  %Asn113 = add i32 %le112, 1
  store i32 %Asn113, i32* %x100
  %19 = load i32, i32* %x100
  br label %block_end107

merge103:                                         ; preds = %while101
  br label %block_end99

block_end107:                                     ; preds = %while_body102
  br label %while101

merge129:                                         ; preds = %block_end143, %block_end131
  %level_count144 = load %objref, %objref* @"variable::level_count"
  %objptr_gen145 = extractvalue %objref %level_count144, 1
  %objptr146 = bitcast %gameobj* %objptr_gen145 to %Draw*
  %n147 = getelementptr inbounds %Draw, %Draw* %objptr146, i32 0, i32 3
  %n148 = load i32, i32* %n147
  %tmp149 = icmp sgt i32 %n148, 99
  br i1 %tmp149, label %then151, label %else156

then130:                                          ; preds = %block_end99
  %level_count132 = load %objref, %objref* @"variable::level_count"
  %objptr_gen133 = extractvalue %objref %level_count132, 1
  %objptr134 = bitcast %gameobj* %objptr_gen133 to %Draw*
  %n135 = getelementptr inbounds %Draw, %Draw* %objptr134, i32 0, i32 3
  %lines_count136 = load %objref, %objref* @"variable::lines_count"
  %objptr_gen137 = extractvalue %objref %lines_count136, 1
  %objptr138 = bitcast %gameobj* %objptr_gen137 to %Draw*
  %n139 = getelementptr inbounds %Draw, %Draw* %objptr138, i32 0, i32 3
  %n140 = load i32, i32* %n139
  %tmp141 = sdiv i32 %n140, 5
  store i32 %tmp141, i32* %n135
  %20 = load i32, i32* %n135
  %level = load %sfSound*, %sfSound** @"variable::snds::level"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %level)
  br label %block_end131

block_end131:                                     ; preds = %then130
  br label %merge129

else142:                                          ; preds = %block_end99
  br label %block_end143

block_end143:                                     ; preds = %else142
  br label %merge129

merge150:                                         ; preds = %block_end157, %then151
  ret i1 true

then151:                                          ; preds = %merge129
  %level_count152 = load %objref, %objref* @"variable::level_count"
  %objptr_gen153 = extractvalue %objref %level_count152, 1
  %objptr154 = bitcast %gameobj* %objptr_gen153 to %Draw*
  %n155 = getelementptr inbounds %Draw, %Draw* %objptr154, i32 0, i32 3
  store i32 99, i32* %n155
  %21 = load i32, i32* %n155
  br label %merge150

else156:                                          ; preds = %merge129
  br label %block_end157

block_end157:                                     ; preds = %else156
  br label %merge150

postret158:                                       ; No predecessors!
  br label %block_end
}

define void @"object::Board.function.checkRows"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Board*
  %lines = alloca i32
  store i32 0, i32* %lines
  %y = alloca i32
  store i32 0, i32* %y
  br label %while

block_end:                                        ; preds = %merge13
  ret void

block_end2:                                       ; preds = %merge
  %lines11 = load i32, i32* %lines
  %tmp12 = icmp sge i32 %lines11, 4
  br i1 %tmp12, label %then14, label %else15

while:                                            ; preds = %block_end4, %entry
  %y3 = load i32, i32* %y
  %board_height = load i32, i32* @"variable::board_height"
  %tmp = icmp slt i32 %y3, %board_height
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %y5 = load i32, i32* %y
  %this6 = load %objref, %objref* %this1
  %checkRow_result = call i1 @"object::Board.function.checkRow"(%objref %this6, i32 %y5)
  br i1 %checkRow_result, label %then, label %else

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %merge7
  br label %while

merge7:                                           ; preds = %block_end8, %then
  %le9 = load i32, i32* %y
  %Asn10 = add i32 %le9, 1
  store i32 %Asn10, i32* %y
  %0 = load i32, i32* %y
  br label %block_end4

then:                                             ; preds = %while_body
  %le = load i32, i32* %lines
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %lines
  %1 = load i32, i32* %lines
  br label %merge7

else:                                             ; preds = %while_body
  br label %block_end8

block_end8:                                       ; preds = %else
  br label %merge7

merge13:                                          ; preds = %merge18, %then14
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen22 = extractvalue %objref %score_count, 1
  %objptr23 = bitcast %gameobj* %objptr_gen22 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 3
  %le24 = load i32, i32* %n
  %lines25 = load i32, i32* %lines
  %points = load [5 x i32], [5 x i32]* @"variable::points"
  %arr = alloca [5 x i32]
  store [5 x i32] %points, [5 x i32]* %arr
  %2 = getelementptr [5 x i32], [5 x i32]* %arr, i32 0, i32 %lines25
  %subscript = load i32, i32* %2
  %level_count = load %objref, %objref* @"variable::level_count"
  %objptr_gen26 = extractvalue %objref %level_count, 1
  %objptr27 = bitcast %gameobj* %objptr_gen26 to %Draw*
  %n28 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 3
  %n29 = load i32, i32* %n28
  %tmp30 = add i32 %n29, 1
  %tmp31 = mul i32 %subscript, %tmp30
  %Asn32 = add i32 %le24, %tmp31
  store i32 %Asn32, i32* %n
  %3 = load i32, i32* %n
  br label %block_end

then14:                                           ; preds = %block_end2
  %tetris = load %sfSound*, %sfSound** @"variable::snds::tetris"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %tetris)
  br label %merge13

else15:                                           ; preds = %block_end2
  %lines16 = load i32, i32* %lines
  %tmp17 = icmp sge i32 %lines16, 1
  br i1 %tmp17, label %then19, label %else20

merge18:                                          ; preds = %block_end21, %then19
  br label %merge13

then19:                                           ; preds = %else15
  %clear = load %sfSound*, %sfSound** @"variable::snds::clear"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %clear)
  br label %merge18

else20:                                           ; preds = %else15
  br label %block_end21

block_end21:                                      ; preds = %else20
  br label %merge18
}

define void @"object::main.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %main*
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.8, i32 0, i32 0))
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %load_result, double 0.000000e+00, double 0.000000e+00)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::main.event.step"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %main*
  %Space = load i32, i32* @"variable:file-../../lib/key.mg::Space"
  %is_pressed_result = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Space)
  br i1 %is_pressed_result, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end5, %then
  br label %block_end

then:                                             ; preds = %entry
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%game_room* getelementptr (%game_room, %game_room* null, i32 1) to i32))
  %game_room = bitcast i8* %malloccall to %game_room*
  store %game_room zeroinitializer, %game_room* %game_room
  %game_room_gen = bitcast %game_room* %game_room to %gameobj*
  %game_room_objnode = getelementptr inbounds %game_room, %game_room* %game_room, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %game_room_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %game_room_objnode, %node* @"node.object::game_room.head")
  %game_room_parent = getelementptr inbounds %game_room, %game_room* %game_room, i32 0, i32 0
  %room_objnode = getelementptr inbounds %room, %room* %game_room_parent, i32 0, i32 1
  %marker3 = getelementptr inbounds %node, %node* %room_objnode, i32 0, i32 2
  store i1 true, i1* %marker3
  call void @list_add(%node* %room_objnode, %node* @"node.object:file-../../lib/game.mg::room.head")
  %room_parent = getelementptr inbounds %room, %room* %game_room_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 1
  %marker4 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker4
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %0 = getelementptr inbounds %gameobj, %gameobj* %game_room_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @game_room.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %0
  %1 = getelementptr inbounds %gameobj, %gameobj* %game_room_gen, i32 0, i32 2
  store i64 %new_id, i64* %1
  %2 = insertvalue %objref undef, i64 %new_id, 0
  %3 = insertvalue %objref %2, %gameobj* %game_room_gen, 1
  call void @"object::game_room.event.create"(%objref %3)
  br label %merge

else:                                             ; preds = %entry
  br label %block_end5

block_end5:                                       ; preds = %else
  br label %merge
}

define void @"object::main.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %main*
  %this3 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::room.event.create"(%objref %this3)
  call void @"function::snds::load"()
  call void @"function:file-../../lib/window.mg::set_clear"(i32 0, i32 0, i32 0)
  call void @"function:file-../../lib/window.mg::set_title"(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @literal.9, i32 0, i32 0))
  call void @"function:file-../../lib/window.mg::set_size"(i32 256, i32 224)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%main = type { %room, %node }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %main*
  %objnode = getelementptr inbounds %main, %main* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %main, %main* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %room, %room* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %room, %room* %2, i32 0, i32 0
  %objnode2 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 1
  call void @list_rem(%node* %objnode2)
  %4 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 0
  ret void
}

define void @"object::game_room.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %game_room*
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.10, i32 0, i32 0))
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %load_result, double 0.000000e+00, double 0.000000e+00)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::game_room.event.step"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %game_room*
  %top_count = load %objref, %objref* @"variable::top_count"
  %objptr_gen3 = extractvalue %objref %top_count, 1
  %objptr4 = bitcast %gameobj* %objptr_gen3 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 3
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen5 = extractvalue %objref %score_count, 1
  %objptr6 = bitcast %gameobj* %objptr_gen5 to %Draw*
  %n7 = getelementptr inbounds %Draw, %Draw* %objptr6, i32 0, i32 3
  %n8 = load i32, i32* %n7
  store i32 %n8, i32* %n
  %0 = load i32, i32* %n
  %this9 = load %objref, %objref* %this1
  call void @_empty_fn(%objref %this9)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::game_room.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %game_room*
  %this3 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::room.event.create"(%objref %this3)
  %music = load %sfSound*, %sfSound** @"variable::snds::music"
  call void @"function:file-../../lib/sound.mg::loop"(%sfSound* %music)
  %b = alloca %objref
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%Board* getelementptr (%Board, %Board* null, i32 1) to i32))
  %Board = bitcast i8* %malloccall to %Board*
  store %Board zeroinitializer, %Board* %Board
  %Board_gen = bitcast %Board* %Board to %gameobj*
  %Board_objnode = getelementptr inbounds %Board, %Board* %Board, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %Board_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %Board_objnode, %node* @"node.object::Board.head")
  %Board_parent = getelementptr inbounds %Board, %Board* %Board, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %Board_parent, i32 0, i32 1
  %marker4 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker4
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %Board_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %0 = getelementptr inbounds %gameobj, %gameobj* %Board_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Board.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %0
  %1 = getelementptr inbounds %gameobj, %gameobj* %Board_gen, i32 0, i32 2
  store i64 %new_id, i64* %1
  %2 = insertvalue %objref undef, i64 %new_id, 0
  %3 = insertvalue %objref %2, %gameobj* %Board_gen, 1
  call void @"object::Board.event.create"(%objref %3)
  store %objref %3, %objref* %b
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %block_end5
  ret void

block_end5:                                       ; preds = %merge
  %malloccall19 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw20 = bitcast i8* %malloccall19 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw20
  %Draw_gen21 = bitcast %Draw* %Draw20 to %gameobj*
  %Draw_objnode22 = getelementptr inbounds %Draw, %Draw* %Draw20, i32 0, i32 1
  %marker23 = getelementptr inbounds %node, %node* %Draw_objnode22, i32 0, i32 2
  store i1 true, i1* %marker23
  call void @list_add(%node* %Draw_objnode22, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent24 = getelementptr inbounds %Draw, %Draw* %Draw20, i32 0, i32 0
  %object_objnode25 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent24, i32 0, i32 1
  %marker26 = getelementptr inbounds %node, %node* %object_objnode25, i32 0, i32 2
  store i1 true, i1* %marker26
  call void @list_add(%node* %object_objnode25, %node* @node.gameobj.head)
  %object_parent27 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent24, i32 0, i32 0
  %old_id28 = load i64, i64* @last_objid
  %new_id29 = add i64 %old_id28, 1
  store i64 %new_id29, i64* @last_objid
  %4 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen21, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %4
  %5 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen21, i32 0, i32 2
  store i64 %new_id29, i64* %5
  %6 = insertvalue %objref undef, i64 %new_id29, 0
  %7 = insertvalue %objref %6, %gameobj* %Draw_gen21, 1
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %7, i32 208, i32 160, i32 2)
  store %objref %7, %objref* @"variable::level_count"
  %8 = load %objref, %objref* @"variable::level_count"
  %malloccall30 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw31 = bitcast i8* %malloccall30 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw31
  %Draw_gen32 = bitcast %Draw* %Draw31 to %gameobj*
  %Draw_objnode33 = getelementptr inbounds %Draw, %Draw* %Draw31, i32 0, i32 1
  %marker34 = getelementptr inbounds %node, %node* %Draw_objnode33, i32 0, i32 2
  store i1 true, i1* %marker34
  call void @list_add(%node* %Draw_objnode33, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent35 = getelementptr inbounds %Draw, %Draw* %Draw31, i32 0, i32 0
  %object_objnode36 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent35, i32 0, i32 1
  %marker37 = getelementptr inbounds %node, %node* %object_objnode36, i32 0, i32 2
  store i1 true, i1* %marker37
  call void @list_add(%node* %object_objnode36, %node* @node.gameobj.head)
  %object_parent38 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent35, i32 0, i32 0
  %old_id39 = load i64, i64* @last_objid
  %new_id40 = add i64 %old_id39, 1
  store i64 %new_id40, i64* @last_objid
  %9 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen32, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %9
  %10 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen32, i32 0, i32 2
  store i64 %new_id40, i64* %10
  %11 = insertvalue %objref undef, i64 %new_id40, 0
  %12 = insertvalue %objref %11, %gameobj* %Draw_gen32, 1
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %12, i32 192, i32 32, i32 6)
  store %objref %12, %objref* @"variable::top_count"
  %13 = load %objref, %objref* @"variable::top_count"
  %malloccall41 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw42 = bitcast i8* %malloccall41 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw42
  %Draw_gen43 = bitcast %Draw* %Draw42 to %gameobj*
  %Draw_objnode44 = getelementptr inbounds %Draw, %Draw* %Draw42, i32 0, i32 1
  %marker45 = getelementptr inbounds %node, %node* %Draw_objnode44, i32 0, i32 2
  store i1 true, i1* %marker45
  call void @list_add(%node* %Draw_objnode44, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent46 = getelementptr inbounds %Draw, %Draw* %Draw42, i32 0, i32 0
  %object_objnode47 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent46, i32 0, i32 1
  %marker48 = getelementptr inbounds %node, %node* %object_objnode47, i32 0, i32 2
  store i1 true, i1* %marker48
  call void @list_add(%node* %object_objnode47, %node* @node.gameobj.head)
  %object_parent49 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent46, i32 0, i32 0
  %old_id50 = load i64, i64* @last_objid
  %new_id51 = add i64 %old_id50, 1
  store i64 %new_id51, i64* @last_objid
  %14 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen43, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %14
  %15 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen43, i32 0, i32 2
  store i64 %new_id51, i64* %15
  %16 = insertvalue %objref undef, i64 %new_id51, 0
  %17 = insertvalue %objref %16, %gameobj* %Draw_gen43, 1
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %17, i32 192, i32 56, i32 6)
  store %objref %17, %objref* @"variable::score_count"
  %18 = load %objref, %objref* @"variable::score_count"
  %malloccall52 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw53 = bitcast i8* %malloccall52 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw53
  %Draw_gen54 = bitcast %Draw* %Draw53 to %gameobj*
  %Draw_objnode55 = getelementptr inbounds %Draw, %Draw* %Draw53, i32 0, i32 1
  %marker56 = getelementptr inbounds %node, %node* %Draw_objnode55, i32 0, i32 2
  store i1 true, i1* %marker56
  call void @list_add(%node* %Draw_objnode55, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent57 = getelementptr inbounds %Draw, %Draw* %Draw53, i32 0, i32 0
  %object_objnode58 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent57, i32 0, i32 1
  %marker59 = getelementptr inbounds %node, %node* %object_objnode58, i32 0, i32 2
  store i1 true, i1* %marker59
  call void @list_add(%node* %object_objnode58, %node* @node.gameobj.head)
  %object_parent60 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent57, i32 0, i32 0
  %old_id61 = load i64, i64* @last_objid
  %new_id62 = add i64 %old_id61, 1
  store i64 %new_id62, i64* @last_objid
  %19 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen54, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %19
  %20 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen54, i32 0, i32 2
  store i64 %new_id62, i64* %20
  %21 = insertvalue %objref undef, i64 %new_id62, 0
  %22 = insertvalue %objref %21, %gameobj* %Draw_gen54, 1
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %22, i32 152, i32 16, i32 3)
  store %objref %22, %objref* @"variable::lines_count"
  %23 = load %objref, %objref* @"variable::lines_count"
  %malloccall63 = tail call i8* @malloc(i32 ptrtoint (%Piece* getelementptr (%Piece, %Piece* null, i32 1) to i32))
  %Piece = bitcast i8* %malloccall63 to %Piece*
  store %Piece zeroinitializer, %Piece* %Piece
  %Piece_gen = bitcast %Piece* %Piece to %gameobj*
  %Piece_objnode = getelementptr inbounds %Piece, %Piece* %Piece, i32 0, i32 1
  %marker64 = getelementptr inbounds %node, %node* %Piece_objnode, i32 0, i32 2
  store i1 true, i1* %marker64
  call void @list_add(%node* %Piece_objnode, %node* @"node.object::Piece.head")
  %Piece_parent = getelementptr inbounds %Piece, %Piece* %Piece, i32 0, i32 0
  %object_objnode65 = getelementptr inbounds %gameobj, %gameobj* %Piece_parent, i32 0, i32 1
  %marker66 = getelementptr inbounds %node, %node* %object_objnode65, i32 0, i32 2
  store i1 true, i1* %marker66
  call void @list_add(%node* %object_objnode65, %node* @node.gameobj.head)
  %object_parent67 = getelementptr inbounds %gameobj, %gameobj* %Piece_parent, i32 0, i32 0
  %old_id68 = load i64, i64* @last_objid
  %new_id69 = add i64 %old_id68, 1
  store i64 %new_id69, i64* @last_objid
  %24 = getelementptr inbounds %gameobj, %gameobj* %Piece_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Piece.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %24
  %25 = getelementptr inbounds %gameobj, %gameobj* %Piece_gen, i32 0, i32 2
  store i64 %new_id69, i64* %25
  %26 = insertvalue %objref undef, i64 %new_id69, 0
  %27 = insertvalue %objref %26, %gameobj* %Piece_gen, 1
  %b70 = load %objref, %objref* %b
  call void @"object::Piece.event.create"(%objref %27, %objref %b70)
  call void @"object::Piece.function.activate"(%objref %27)
  br label %block_end

while:                                            ; preds = %block_end7, %entry
  %i6 = load i32, i32* %i
  %tmp = icmp slt i32 %i6, 7
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i8 = load i32, i32* %i
  %subscript = getelementptr [7 x %objref], [7 x %objref]* @"variable::piece_counts", i32 0, i32 %i8
  %malloccall9 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw = bitcast i8* %malloccall9 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw
  %Draw_gen = bitcast %Draw* %Draw to %gameobj*
  %Draw_objnode = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 1
  %marker10 = getelementptr inbounds %node, %node* %Draw_objnode, i32 0, i32 2
  store i1 true, i1* %marker10
  call void @list_add(%node* %Draw_objnode, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 0
  %object_objnode11 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 1
  %marker12 = getelementptr inbounds %node, %node* %object_objnode11, i32 0, i32 2
  store i1 true, i1* %marker12
  call void @list_add(%node* %object_objnode11, %node* @node.gameobj.head)
  %object_parent13 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 0
  %old_id14 = load i64, i64* @last_objid
  %new_id15 = add i64 %old_id14, 1
  store i64 %new_id15, i64* @last_objid
  %28 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %28
  %29 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 2
  store i64 %new_id15, i64* %29
  %30 = insertvalue %objref undef, i64 %new_id15, 0
  %31 = insertvalue %objref %30, %gameobj* %Draw_gen, 1
  %i16 = load i32, i32* %i
  %tmp17 = mul i32 16, %i16
  %tmp18 = add i32 88, %tmp17
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %31, i32 48, i32 %tmp18, i32 3)
  store %objref %31, %objref* %subscript
  %32 = load %objref, %objref* %subscript
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %33 = load i32, i32* %i
  br label %block_end7

merge:                                            ; preds = %while
  br label %block_end5

block_end7:                                       ; preds = %while_body
  br label %while
}

define void @"delete_%game_room = type { %room, %node }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %game_room*
  %objnode = getelementptr inbounds %game_room, %game_room* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %game_room, %game_room* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %room, %room* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %room, %room* %2, i32 0, i32 0
  %objnode2 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 1
  call void @list_rem(%node* %objnode2)
  %4 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 0
  ret void
}

define void @"object::game_over.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %game_over*
  %timer = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 3
  %timer3 = load i32, i32* %timer
  %game_over_fade = load i32, i32* @"variable::game_over_fade"
  %tmp = icmp sge i32 %timer3, %game_over_fade
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end4, %then
  br label %block_end

then:                                             ; preds = %entry
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @literal.11, i32 0, i32 0))
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %load_result, double 0.000000e+00, double 0.000000e+00)
  br label %merge

else:                                             ; preds = %entry
  br label %block_end4

block_end4:                                       ; preds = %else
  br label %merge
}

define void @"object::game_over.event.step"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %game_over*
  %timer = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 3
  %le = load i32, i32* %timer
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %timer
  %0 = load i32, i32* %timer
  %timer3 = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 3
  %timer4 = load i32, i32* %timer3
  %game_over_fade = load i32, i32* @"variable::game_over_fade"
  %tmp = icmp eq i32 %timer4, %game_over_fade
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge19
  ret void

merge:                                            ; preds = %block_end6, %then
  %timer7 = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 3
  %timer8 = load i32, i32* %timer7
  %game_over_fade9 = load i32, i32* @"variable::game_over_fade"
  %game_over_delay = load i32, i32* @"variable::game_over_delay"
  %tmp10 = add i32 %game_over_fade9, %game_over_delay
  %tmp11 = icmp sge i32 %timer8, %tmp10
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen12 = extractvalue %objref %score_count, 1
  %objptr13 = bitcast %gameobj* %objptr_gen12 to %Draw*
  %n = getelementptr inbounds %Draw, %Draw* %objptr13, i32 0, i32 3
  %n14 = load i32, i32* %n
  %n15 = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 2
  %n16 = load i32, i32* %n15
  %tmp17 = icmp slt i32 %n14, %n16
  %tmp18 = and i1 %tmp11, %tmp17
  br i1 %tmp18, label %then20, label %else53

then:                                             ; preds = %entry
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw = bitcast i8* %malloccall to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw
  %Draw_gen = bitcast %Draw* %Draw to %gameobj*
  %Draw_objnode = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %Draw_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %Draw_objnode, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 1
  %marker5 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker5
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %1 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %1
  %2 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 2
  store i64 %new_id, i64* %2
  %3 = insertvalue %objref undef, i64 %new_id, 0
  %4 = insertvalue %objref %3, %gameobj* %Draw_gen, 1
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %4, i32 104, i32 136, i32 6)
  store %objref %4, %objref* @"variable::score_count"
  %5 = load %objref, %objref* @"variable::score_count"
  br label %merge

else:                                             ; preds = %entry
  br label %block_end6

block_end6:                                       ; preds = %else
  br label %merge

merge19:                                          ; preds = %block_end54, %block_end21
  %this55 = load %objref, %objref* %this1
  call void @_empty_fn(%objref %this55)
  br label %block_end

then20:                                           ; preds = %merge
  %add = alloca i32
  %n22 = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 2
  %n23 = load i32, i32* %n22
  %game_over_delay24 = load i32, i32* @"variable::game_over_delay"
  %tmp25 = sdiv i32 %n23, %game_over_delay24
  %tmp26 = sdiv i32 %tmp25, 2
  %tmp27 = add i32 %tmp26, 1
  store i32 %tmp27, i32* %add
  %score_count28 = load %objref, %objref* @"variable::score_count"
  %objptr_gen29 = extractvalue %objref %score_count28, 1
  %objptr30 = bitcast %gameobj* %objptr_gen29 to %Draw*
  %n31 = getelementptr inbounds %Draw, %Draw* %objptr30, i32 0, i32 3
  %le32 = load i32, i32* %n31
  %add33 = load i32, i32* %add
  %Asn34 = add i32 %le32, %add33
  store i32 %Asn34, i32* %n31
  %6 = load i32, i32* %n31
  %score_count35 = load %objref, %objref* @"variable::score_count"
  %objptr_gen36 = extractvalue %objref %score_count35, 1
  %objptr37 = bitcast %gameobj* %objptr_gen36 to %Draw*
  %n38 = getelementptr inbounds %Draw, %Draw* %objptr37, i32 0, i32 3
  %n39 = load i32, i32* %n38
  %n40 = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 2
  %n41 = load i32, i32* %n40
  %tmp42 = icmp sgt i32 %n39, %n41
  br i1 %tmp42, label %then44, label %else51

block_end21:                                      ; preds = %merge43
  br label %merge19

merge43:                                          ; preds = %block_end52, %then44
  br label %block_end21

then44:                                           ; preds = %then20
  %score_count45 = load %objref, %objref* @"variable::score_count"
  %objptr_gen46 = extractvalue %objref %score_count45, 1
  %objptr47 = bitcast %gameobj* %objptr_gen46 to %Draw*
  %n48 = getelementptr inbounds %Draw, %Draw* %objptr47, i32 0, i32 3
  %n49 = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 2
  %n50 = load i32, i32* %n49
  store i32 %n50, i32* %n48
  %7 = load i32, i32* %n48
  br label %merge43

else51:                                           ; preds = %then20
  br label %block_end52

block_end52:                                      ; preds = %else51
  br label %merge43

else53:                                           ; preds = %merge
  br label %block_end54

block_end54:                                      ; preds = %else53
  br label %merge19
}

define void @"object::game_over.event.create"(%objref %this, i32 %score) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %score2 = alloca i32
  store i32 %score, i32* %score2
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr3 = bitcast %gameobj* %objptr_gen to %game_over*
  %this4 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::room.event.create"(%objref %this4)
  %n = getelementptr inbounds %game_over, %game_over* %objptr3, i32 0, i32 2
  %score5 = load i32, i32* %score2
  store i32 %score5, i32* %n
  %0 = load i32, i32* %n
  call void @"function:file-../../lib/window.mg::set_clear"(i32 0, i32 0, i32 0)
  %music = load %sfSound*, %sfSound** @"variable::snds::music"
  call void @"function:file-../../lib/sound.mg::stop"(%sfSound* %music)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%game_over = type { %room, %node, i32, i32 }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %game_over*
  %objnode = getelementptr inbounds %game_over, %game_over* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %game_over, %game_over* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %room, %room* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %room, %room* %2, i32 0, i32 0
  %objnode2 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 1
  call void @list_rem(%node* %objnode2)
  %4 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 0
  ret void
}

define void @global_step() {
entry:
  %tail = alloca %node
  %marker = getelementptr inbounds %node, %node* %tail, i32 0, i32 2
  store i1 false, i1* %marker
  %curr_ptr = alloca %node*
  %next_ptr = alloca %node*
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  store %node* @node.gameobj.head, %node** %curr_ptr
  %0 = load %node*, %node** getelementptr inbounds (%node, %node* @node.gameobj.head, i32 0, i32 1)
  store %node* %0, %node** %next_ptr
  br label %while

while:                                            ; preds = %merge3, %entry
  %curr = load %node*, %node** %next_ptr
  %1 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next = load %node*, %node** %1
  %2 = ptrtoint %node* %curr to i64
  %3 = ptrtoint %node* %next to i64
  %4 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next, %node** %next_ptr
  %cont = icmp ne %node* %curr, @node.gameobj.head
  br i1 %cont, label %while_body, label %merge

while_body:                                       ; preds = %while
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker1 = load i1, i1* %markerptr
  %cont2 = icmp eq i1 %marker1, true
  br i1 %cont2, label %then, label %else6

merge:                                            ; preds = %while
  call void @list_rem(%node* %tail)
  ret void

merge3:                                           ; preds = %merge8, %merge4
  br label %while

then:                                             ; preds = %while_body
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%gameobj, %gameobj* null, i32 0, i32 1) to i64)
  %objptr = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %objptr, i32 0, i32 2
  %id = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id, 0
  br i1 %is_removed, label %then5, label %else

merge4:                                           ; preds = %else, %then5
  br label %merge3

then5:                                            ; preds = %then
  %5 = getelementptr inbounds %gameobj, %gameobj* %objptr, i32 0, i32 0
  %this_tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %5
  %this_stepptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %this_tbl, i32 0, i32 0
  %this_step = load void (%objref)*, void (%objref)** %this_stepptr
  %6 = insertvalue %objref undef, i64 %id, 0
  %7 = insertvalue %objref %6, %gameobj* %objptr, 1
  call void %this_step(%objref %7)
  br label %merge4

else:                                             ; preds = %then
  call void @list_rem(%node* %curr)
  store %gameobj zeroinitializer, %gameobj* %objptr
  %8 = bitcast %gameobj* %objptr to i8*
  tail call void @free(i8* %8)
  br label %merge4

else6:                                            ; preds = %while_body
  %cont7 = icmp eq %node* %curr, %tail
  br i1 %cont7, label %then9, label %else10

merge8:                                           ; preds = %else10, %then9
  br label %merge3

then9:                                            ; preds = %else6
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  br label %merge8

else10:                                           ; preds = %else6
  br label %merge8
}

declare void @free(i8*)

define void @global_draw() {
entry:
  %tail = alloca %node
  %marker = getelementptr inbounds %node, %node* %tail, i32 0, i32 2
  store i1 false, i1* %marker
  %curr_ptr = alloca %node*
  %next_ptr = alloca %node*
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  store %node* @node.gameobj.head, %node** %curr_ptr
  %0 = load %node*, %node** getelementptr inbounds (%node, %node* @node.gameobj.head, i32 0, i32 1)
  store %node* %0, %node** %next_ptr
  br label %while

while:                                            ; preds = %merge3, %entry
  %curr = load %node*, %node** %next_ptr
  %1 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next = load %node*, %node** %1
  %2 = ptrtoint %node* %curr to i64
  %3 = ptrtoint %node* %next to i64
  %4 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next, %node** %next_ptr
  %cont = icmp ne %node* %curr, @node.gameobj.head
  br i1 %cont, label %while_body, label %merge

while_body:                                       ; preds = %while
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker1 = load i1, i1* %markerptr
  %cont2 = icmp eq i1 %marker1, true
  br i1 %cont2, label %then, label %else6

merge:                                            ; preds = %while
  call void @list_rem(%node* %tail)
  ret void

merge3:                                           ; preds = %merge8, %merge4
  br label %while

then:                                             ; preds = %while_body
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%gameobj, %gameobj* null, i32 0, i32 1) to i64)
  %objptr = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %objptr, i32 0, i32 2
  %id = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id, 0
  br i1 %is_removed, label %then5, label %else

merge4:                                           ; preds = %else, %then5
  br label %merge3

then5:                                            ; preds = %then
  %5 = getelementptr inbounds %gameobj, %gameobj* %objptr, i32 0, i32 0
  %this_tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %5
  %this_drawptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %this_tbl, i32 0, i32 2
  %this_draw = load void (%objref)*, void (%objref)** %this_drawptr
  %6 = insertvalue %objref undef, i64 %id, 0
  %7 = insertvalue %objref %6, %gameobj* %objptr, 1
  call void %this_draw(%objref %7)
  br label %merge4

else:                                             ; preds = %then
  call void @list_rem(%node* %curr)
  store %gameobj zeroinitializer, %gameobj* %objptr
  %8 = bitcast %gameobj* %objptr to i8*
  tail call void @free(i8* %8)
  br label %merge4

else6:                                            ; preds = %while_body
  %cont7 = icmp eq %node* %curr, %tail
  br i1 %cont7, label %then9, label %else10

merge8:                                           ; preds = %else10, %then9
  br label %merge3

then9:                                            ; preds = %else6
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @node.gameobj.head)
  br label %merge8

else10:                                           ; preds = %else6
  br label %merge8
}

declare noalias i8* @malloc(i32)

define void @global_create() {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%main* getelementptr (%main, %main* null, i32 1) to i32))
  %main = bitcast i8* %malloccall to %main*
  store %main zeroinitializer, %main* %main
  %main_gen = bitcast %main* %main to %gameobj*
  %main_objnode = getelementptr inbounds %main, %main* %main, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %main_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %main_objnode, %node* @"node.object::main.head")
  %main_parent = getelementptr inbounds %main, %main* %main, i32 0, i32 0
  %room_objnode = getelementptr inbounds %room, %room* %main_parent, i32 0, i32 1
  %marker1 = getelementptr inbounds %node, %node* %room_objnode, i32 0, i32 2
  store i1 true, i1* %marker1
  call void @list_add(%node* %room_objnode, %node* @"node.object:file-../../lib/game.mg::room.head")
  %room_parent = getelementptr inbounds %room, %room* %main_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 1
  %marker2 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker2
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %0 = getelementptr inbounds %gameobj, %gameobj* %main_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @main.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %0
  %1 = getelementptr inbounds %gameobj, %gameobj* %main_gen, i32 0, i32 2
  store i64 %new_id, i64* %1
  %2 = insertvalue %objref undef, i64 %new_id, 0
  %3 = insertvalue %objref %2, %gameobj* %main_gen, 1
  call void @"object::main.event.create"(%objref %3)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}
