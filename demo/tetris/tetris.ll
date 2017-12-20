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
  %pressed = getelementptr inbounds %Checker, %Checker* %objptr, i32 0, i32 2
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
  %key_pressed_result = call i1 @key_pressed(i32 %i5)
  %i6 = load i32, i32* %i
  %subscript = getelementptr [101 x i1], [101 x i1]* %pressed, i32 0, i32 %i6
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
  %pressed = getelementptr inbounds %Checker, %Checker* %objptr, i32 0, i32 2
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
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %x4 = load double, double* %x
  %a5 = load %objref, %objref* %a1
  %objptr_gen6 = extractvalue %objref %a5, 1
  %objptr7 = bitcast %gameobj* %objptr_gen6 to %obj*
  %hitbox_h8 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 2
  %hitbox_w9 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 3
  %hitbox_offy10 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 4
  %hitbox_offx11 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 5
  %origin_y12 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 6
  %origin_x13 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 7
  %vspeed14 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 8
  %hspeed15 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 9
  %y16 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 10
  %x17 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 11
  %spr18 = getelementptr inbounds %obj, %obj* %objptr7, i32 0, i32 12
  %hitbox_offx19 = load double, double* %hitbox_offx11
  %tmp = fadd double %x4, %hitbox_offx19
  store double %tmp, double* %al
  %au = alloca double
  %a20 = load %objref, %objref* %a1
  %objptr_gen21 = extractvalue %objref %a20, 1
  %objptr22 = bitcast %gameobj* %objptr_gen21 to %obj*
  %hitbox_h23 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 2
  %hitbox_w24 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 3
  %hitbox_offy25 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 4
  %hitbox_offx26 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 5
  %origin_y27 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 6
  %origin_x28 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 7
  %vspeed29 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 8
  %hspeed30 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 9
  %y31 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 10
  %x32 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 11
  %spr33 = getelementptr inbounds %obj, %obj* %objptr22, i32 0, i32 12
  %y34 = load double, double* %y31
  %a35 = load %objref, %objref* %a1
  %objptr_gen36 = extractvalue %objref %a35, 1
  %objptr37 = bitcast %gameobj* %objptr_gen36 to %obj*
  %hitbox_h38 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 2
  %hitbox_w39 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 3
  %hitbox_offy40 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 4
  %hitbox_offx41 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 5
  %origin_y42 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 6
  %origin_x43 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 7
  %vspeed44 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 8
  %hspeed45 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 9
  %y46 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 10
  %x47 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 11
  %spr48 = getelementptr inbounds %obj, %obj* %objptr37, i32 0, i32 12
  %hitbox_offy49 = load double, double* %hitbox_offy40
  %tmp50 = fadd double %y34, %hitbox_offy49
  store double %tmp50, double* %au
  %ar = alloca double
  %a51 = load %objref, %objref* %a1
  %objptr_gen52 = extractvalue %objref %a51, 1
  %objptr53 = bitcast %gameobj* %objptr_gen52 to %obj*
  %hitbox_h54 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 2
  %hitbox_w55 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 3
  %hitbox_offy56 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 4
  %hitbox_offx57 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 5
  %origin_y58 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 6
  %origin_x59 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 7
  %vspeed60 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 8
  %hspeed61 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 9
  %y62 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 10
  %x63 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 11
  %spr64 = getelementptr inbounds %obj, %obj* %objptr53, i32 0, i32 12
  %x65 = load double, double* %x63
  %a66 = load %objref, %objref* %a1
  %objptr_gen67 = extractvalue %objref %a66, 1
  %objptr68 = bitcast %gameobj* %objptr_gen67 to %obj*
  %hitbox_h69 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 2
  %hitbox_w70 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 3
  %hitbox_offy71 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 4
  %hitbox_offx72 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 5
  %origin_y73 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 6
  %origin_x74 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 7
  %vspeed75 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 8
  %hspeed76 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 9
  %y77 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 10
  %x78 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 11
  %spr79 = getelementptr inbounds %obj, %obj* %objptr68, i32 0, i32 12
  %hitbox_offx80 = load double, double* %hitbox_offx72
  %tmp81 = fadd double %x65, %hitbox_offx80
  %a82 = load %objref, %objref* %a1
  %objptr_gen83 = extractvalue %objref %a82, 1
  %objptr84 = bitcast %gameobj* %objptr_gen83 to %obj*
  %hitbox_h85 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 2
  %hitbox_w86 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 3
  %hitbox_offy87 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 4
  %hitbox_offx88 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 5
  %origin_y89 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 6
  %origin_x90 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 7
  %vspeed91 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 8
  %hspeed92 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 9
  %y93 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 10
  %x94 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 11
  %spr95 = getelementptr inbounds %obj, %obj* %objptr84, i32 0, i32 12
  %hitbox_w96 = load double, double* %hitbox_w86
  %tmp97 = fadd double %tmp81, %hitbox_w96
  store double %tmp97, double* %ar
  %ad = alloca double
  %a98 = load %objref, %objref* %a1
  %objptr_gen99 = extractvalue %objref %a98, 1
  %objptr100 = bitcast %gameobj* %objptr_gen99 to %obj*
  %hitbox_h101 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 2
  %hitbox_w102 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 3
  %hitbox_offy103 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 4
  %hitbox_offx104 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 5
  %origin_y105 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 6
  %origin_x106 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 7
  %vspeed107 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 8
  %hspeed108 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 9
  %y109 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 10
  %x110 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 11
  %spr111 = getelementptr inbounds %obj, %obj* %objptr100, i32 0, i32 12
  %y112 = load double, double* %y109
  %a113 = load %objref, %objref* %a1
  %objptr_gen114 = extractvalue %objref %a113, 1
  %objptr115 = bitcast %gameobj* %objptr_gen114 to %obj*
  %hitbox_h116 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 2
  %hitbox_w117 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 3
  %hitbox_offy118 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 4
  %hitbox_offx119 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 5
  %origin_y120 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 6
  %origin_x121 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 7
  %vspeed122 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 8
  %hspeed123 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 9
  %y124 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 10
  %x125 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 11
  %spr126 = getelementptr inbounds %obj, %obj* %objptr115, i32 0, i32 12
  %hitbox_offy127 = load double, double* %hitbox_offy118
  %tmp128 = fadd double %y112, %hitbox_offy127
  %a129 = load %objref, %objref* %a1
  %objptr_gen130 = extractvalue %objref %a129, 1
  %objptr131 = bitcast %gameobj* %objptr_gen130 to %obj*
  %hitbox_h132 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 2
  %hitbox_w133 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 3
  %hitbox_offy134 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 4
  %hitbox_offx135 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 5
  %origin_y136 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 6
  %origin_x137 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 7
  %vspeed138 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 8
  %hspeed139 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 9
  %y140 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 10
  %x141 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 11
  %spr142 = getelementptr inbounds %obj, %obj* %objptr131, i32 0, i32 12
  %hitbox_h143 = load double, double* %hitbox_h132
  %tmp144 = fadd double %tmp128, %hitbox_h143
  store double %tmp144, double* %ad
  %bl = alloca double
  %b145 = load %objref, %objref* %b2
  %objptr_gen146 = extractvalue %objref %b145, 1
  %objptr147 = bitcast %gameobj* %objptr_gen146 to %obj*
  %hitbox_h148 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 2
  %hitbox_w149 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 3
  %hitbox_offy150 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 4
  %hitbox_offx151 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 5
  %origin_y152 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 6
  %origin_x153 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 7
  %vspeed154 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 8
  %hspeed155 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 9
  %y156 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 10
  %x157 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 11
  %spr158 = getelementptr inbounds %obj, %obj* %objptr147, i32 0, i32 12
  %x159 = load double, double* %x157
  %b160 = load %objref, %objref* %b2
  %objptr_gen161 = extractvalue %objref %b160, 1
  %objptr162 = bitcast %gameobj* %objptr_gen161 to %obj*
  %hitbox_h163 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 2
  %hitbox_w164 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 3
  %hitbox_offy165 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 4
  %hitbox_offx166 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 5
  %origin_y167 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 6
  %origin_x168 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 7
  %vspeed169 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 8
  %hspeed170 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 9
  %y171 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 10
  %x172 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 11
  %spr173 = getelementptr inbounds %obj, %obj* %objptr162, i32 0, i32 12
  %hitbox_offx174 = load double, double* %hitbox_offx166
  %tmp175 = fadd double %x159, %hitbox_offx174
  store double %tmp175, double* %bl
  %bu = alloca double
  %b176 = load %objref, %objref* %b2
  %objptr_gen177 = extractvalue %objref %b176, 1
  %objptr178 = bitcast %gameobj* %objptr_gen177 to %obj*
  %hitbox_h179 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 2
  %hitbox_w180 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 3
  %hitbox_offy181 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 4
  %hitbox_offx182 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 5
  %origin_y183 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 6
  %origin_x184 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 7
  %vspeed185 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 8
  %hspeed186 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 9
  %y187 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 10
  %x188 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 11
  %spr189 = getelementptr inbounds %obj, %obj* %objptr178, i32 0, i32 12
  %y190 = load double, double* %y187
  %b191 = load %objref, %objref* %b2
  %objptr_gen192 = extractvalue %objref %b191, 1
  %objptr193 = bitcast %gameobj* %objptr_gen192 to %obj*
  %hitbox_h194 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 2
  %hitbox_w195 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 3
  %hitbox_offy196 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 4
  %hitbox_offx197 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 5
  %origin_y198 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 6
  %origin_x199 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 7
  %vspeed200 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 8
  %hspeed201 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 9
  %y202 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 10
  %x203 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 11
  %spr204 = getelementptr inbounds %obj, %obj* %objptr193, i32 0, i32 12
  %hitbox_offy205 = load double, double* %hitbox_offy196
  %tmp206 = fadd double %y190, %hitbox_offy205
  store double %tmp206, double* %bu
  %br = alloca double
  %b207 = load %objref, %objref* %b2
  %objptr_gen208 = extractvalue %objref %b207, 1
  %objptr209 = bitcast %gameobj* %objptr_gen208 to %obj*
  %hitbox_h210 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 2
  %hitbox_w211 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 3
  %hitbox_offy212 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 4
  %hitbox_offx213 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 5
  %origin_y214 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 6
  %origin_x215 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 7
  %vspeed216 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 8
  %hspeed217 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 9
  %y218 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 10
  %x219 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 11
  %spr220 = getelementptr inbounds %obj, %obj* %objptr209, i32 0, i32 12
  %x221 = load double, double* %x219
  %b222 = load %objref, %objref* %b2
  %objptr_gen223 = extractvalue %objref %b222, 1
  %objptr224 = bitcast %gameobj* %objptr_gen223 to %obj*
  %hitbox_h225 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 2
  %hitbox_w226 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 3
  %hitbox_offy227 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 4
  %hitbox_offx228 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 5
  %origin_y229 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 6
  %origin_x230 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 7
  %vspeed231 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 8
  %hspeed232 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 9
  %y233 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 10
  %x234 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 11
  %spr235 = getelementptr inbounds %obj, %obj* %objptr224, i32 0, i32 12
  %hitbox_offx236 = load double, double* %hitbox_offx228
  %tmp237 = fadd double %x221, %hitbox_offx236
  %b238 = load %objref, %objref* %b2
  %objptr_gen239 = extractvalue %objref %b238, 1
  %objptr240 = bitcast %gameobj* %objptr_gen239 to %obj*
  %hitbox_h241 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 2
  %hitbox_w242 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 3
  %hitbox_offy243 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 4
  %hitbox_offx244 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 5
  %origin_y245 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 6
  %origin_x246 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 7
  %vspeed247 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 8
  %hspeed248 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 9
  %y249 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 10
  %x250 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 11
  %spr251 = getelementptr inbounds %obj, %obj* %objptr240, i32 0, i32 12
  %hitbox_w252 = load double, double* %hitbox_w242
  %tmp253 = fadd double %tmp237, %hitbox_w252
  store double %tmp253, double* %br
  %bd = alloca double
  %b254 = load %objref, %objref* %b2
  %objptr_gen255 = extractvalue %objref %b254, 1
  %objptr256 = bitcast %gameobj* %objptr_gen255 to %obj*
  %hitbox_h257 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 2
  %hitbox_w258 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 3
  %hitbox_offy259 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 4
  %hitbox_offx260 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 5
  %origin_y261 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 6
  %origin_x262 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 7
  %vspeed263 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 8
  %hspeed264 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 9
  %y265 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 10
  %x266 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 11
  %spr267 = getelementptr inbounds %obj, %obj* %objptr256, i32 0, i32 12
  %y268 = load double, double* %y265
  %b269 = load %objref, %objref* %b2
  %objptr_gen270 = extractvalue %objref %b269, 1
  %objptr271 = bitcast %gameobj* %objptr_gen270 to %obj*
  %hitbox_h272 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 2
  %hitbox_w273 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 3
  %hitbox_offy274 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 4
  %hitbox_offx275 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 5
  %origin_y276 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 6
  %origin_x277 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 7
  %vspeed278 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 8
  %hspeed279 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 9
  %y280 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 10
  %x281 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 11
  %spr282 = getelementptr inbounds %obj, %obj* %objptr271, i32 0, i32 12
  %hitbox_offy283 = load double, double* %hitbox_offy274
  %tmp284 = fadd double %y268, %hitbox_offy283
  %b285 = load %objref, %objref* %b2
  %objptr_gen286 = extractvalue %objref %b285, 1
  %objptr287 = bitcast %gameobj* %objptr_gen286 to %obj*
  %hitbox_h288 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 2
  %hitbox_w289 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 3
  %hitbox_offy290 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 4
  %hitbox_offx291 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 5
  %origin_y292 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 6
  %origin_x293 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 7
  %vspeed294 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 8
  %hspeed295 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 9
  %y296 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 10
  %x297 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 11
  %spr298 = getelementptr inbounds %obj, %obj* %objptr287, i32 0, i32 12
  %hitbox_h299 = load double, double* %hitbox_h288
  %tmp300 = fadd double %tmp284, %hitbox_h299
  store double %tmp300, double* %bd
  %al301 = load double, double* %al
  %br302 = load double, double* %br
  %tmp303 = fcmp olt double %al301, %br302
  %ar304 = load double, double* %ar
  %bl305 = load double, double* %bl
  %tmp306 = fcmp ogt double %ar304, %bl305
  %tmp307 = and i1 %tmp303, %tmp306
  %au308 = load double, double* %au
  %bd309 = load double, double* %bd
  %tmp310 = fcmp olt double %au308, %bd309
  %tmp311 = and i1 %tmp307, %tmp310
  %ad312 = load double, double* %ad
  %bu313 = load double, double* %bu
  %tmp314 = fcmp ogt double %ad312, %bu313
  %tmp315 = and i1 %tmp311, %tmp314
  ret i1 %tmp315

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
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %le = load double, double* %x
  %hspeed2 = load double, double* %hspeed
  %Asn = fadd double %le, %hspeed2
  store double %Asn, double* %x
  %0 = load double, double* %x
  %le3 = load double, double* %y
  %vspeed4 = load double, double* %vspeed
  %Asn5 = fadd double %le3, %vspeed4
  store double %Asn5, double* %y
  %1 = load double, double* %y
  %spr6 = load %sfSprite*, %sfSprite** %spr
  %x7 = load double, double* %x
  %origin_x8 = load double, double* %origin_x
  %tmp = fsub double %x7, %origin_x8
  %y9 = load double, double* %y
  %origin_y10 = load double, double* %origin_y
  %tmp11 = fsub double %y9, %origin_y10
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %spr6, double %tmp, double %tmp11)
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
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %y5 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x6 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %x7 = load double, double* %x2
  %this8 = load %objref, %objref* %this1
  %objptr_gen9 = extractvalue %objref %this8, 1
  %objptr10 = bitcast %gameobj* %objptr_gen9 to %obj*
  %hitbox_h11 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 2
  %hitbox_w12 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 3
  %hitbox_offy13 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 4
  %hitbox_offx14 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 5
  %origin_y15 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 6
  %origin_x16 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 7
  %vspeed17 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 8
  %hspeed18 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 9
  %y19 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 10
  %x20 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 11
  %spr21 = getelementptr inbounds %obj, %obj* %objptr10, i32 0, i32 12
  store double %x7, double* %x20
  %0 = load double, double* %x20
  %y22 = load double, double* %y3
  %this23 = load %objref, %objref* %this1
  %objptr_gen24 = extractvalue %objref %this23, 1
  %objptr25 = bitcast %gameobj* %objptr_gen24 to %obj*
  %hitbox_h26 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 2
  %hitbox_w27 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 3
  %hitbox_offy28 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 4
  %hitbox_offx29 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 5
  %origin_y30 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 6
  %origin_x31 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 7
  %vspeed32 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 8
  %hspeed33 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 9
  %y34 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 10
  %x35 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 11
  %spr36 = getelementptr inbounds %obj, %obj* %objptr25, i32 0, i32 12
  store double %y22, double* %y34
  %1 = load double, double* %y34
  %sprite_name37 = load i8*, i8** %sprite_name4
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* %sprite_name37)
  store %sfSprite* %load_result, %sfSprite** %spr
  %2 = load %sfSprite*, %sfSprite** %spr
  %spr38 = load %sfSprite*, %sfSprite** %spr
  %width_result = call i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %spr38)
  %3 = sitofp i32 %width_result to double
  %tmp = fmul double %3, 5.000000e-01
  store double %tmp, double* %origin_x
  %4 = load double, double* %origin_x
  %spr39 = load %sfSprite*, %sfSprite** %spr
  %height_result = call i32 @"function:file-../../lib/sprite.mg::height"(%sfSprite* %spr39)
  %5 = sitofp i32 %height_result to double
  %tmp40 = fmul double %5, 5.000000e-01
  store double %tmp40, double* %origin_y
  %6 = load double, double* %origin_y
  %this41 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.center_hitbox_abs"(%objref %this41, double 0.000000e+00, double 0.000000e+00)
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
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %y6 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x7 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %x8 = load double, double* %x2
  store double %x8, double* %hitbox_offx
  %0 = load double, double* %hitbox_offx
  %y9 = load double, double* %y3
  store double %y9, double* %hitbox_offy
  %1 = load double, double* %hitbox_offy
  %w10 = load double, double* %w4
  store double %w10, double* %hitbox_w
  %2 = load double, double* %hitbox_w
  %h11 = load double, double* %h5
  store double %h11, double* %hitbox_h
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
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %sw = alloca double
  %xprop4 = load double, double* %xprop2
  %spr5 = load %sfSprite*, %sfSprite** %spr
  %width_result = call i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %spr5)
  %0 = sitofp i32 %width_result to double
  %tmp = fmul double %xprop4, %0
  store double %tmp, double* %sw
  %sh = alloca double
  %yprop6 = load double, double* %yprop3
  %spr7 = load %sfSprite*, %sfSprite** %spr
  %height_result = call i32 @"function:file-../../lib/sprite.mg::height"(%sfSprite* %spr7)
  %1 = sitofp i32 %height_result to double
  %tmp8 = fmul double %yprop6, %1
  store double %tmp8, double* %sh
  %sw9 = load double, double* %sw
  %sh10 = load double, double* %sh
  %this11 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.center_hitbox_abs"(%objref %this11, double %sw9, double %sh10)
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
  %hitbox_h = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 2
  %hitbox_w = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 3
  %hitbox_offy = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 4
  %hitbox_offx = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 5
  %origin_y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 6
  %origin_x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 7
  %vspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 8
  %hspeed = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 9
  %y = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
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
  %digits = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 5
  %y = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %x = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 8
  %div = alloca i32
  store i32 1, i32* %div
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %merge25
  ret void

block_end2:                                       ; preds = %merge
  %x9 = alloca i32
  %x10 = load i32, i32* %x
  store i32 %x10, i32* %x9
  %n11 = alloca i32
  %this12 = load %objref, %objref* %this1
  %objptr_gen13 = extractvalue %objref %this12, 1
  %objptr14 = bitcast %gameobj* %objptr_gen13 to %Draw*
  %digits15 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 2
  %n16 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 3
  %height17 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 4
  %width18 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 5
  %y19 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 6
  %x20 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 7
  %spr21 = getelementptr inbounds %Draw, %Draw* %objptr14, i32 0, i32 8
  %n22 = load i32, i32* %n16
  store i32 %n22, i32* %n11
  br label %while23

while:                                            ; preds = %block_end6, %entry
  %i3 = load i32, i32* %i
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

while23:                                          ; preds = %block_end28, %block_end2
  %div26 = load i32, i32* %div
  %tmp27 = icmp sgt i32 %div26, 0
  br i1 %tmp27, label %while_body24, label %merge25

while_body24:                                     ; preds = %while23
  %d = alloca i32
  %n29 = load i32, i32* %n11
  %div30 = load i32, i32* %div
  %tmp31 = sdiv i32 %n29, %div30
  %tmp32 = srem i32 %tmp31, 10
  store i32 %tmp32, i32* %d
  %spr33 = load %sfSprite*, %sfSprite** %spr
  %x34 = load i32, i32* %x9
  %2 = sitofp i32 %x34 to double
  %y35 = load i32, i32* %y
  %3 = sitofp i32 %y35 to double
  %d36 = load i32, i32* %d
  %tmp37 = mul i32 8, %d36
  %4 = insertvalue [4 x i32] undef, i32 %tmp37, 0
  %5 = insertvalue [4 x i32] %4, i32 0, 1
  %6 = insertvalue [4 x i32] %5, i32 8, 2
  %7 = insertvalue [4 x i32] %6, i32 8, 3
  call void @"function:file-../../lib/sprite.mg::render_rect"(%sfSprite* %spr33, double %2, double %3, [4 x i32] %7)
  %le38 = load i32, i32* %x9
  %Asn39 = add i32 %le38, 8
  store i32 %Asn39, i32* %x9
  %8 = load i32, i32* %x9
  %le40 = load i32, i32* %div
  %Asn41 = sdiv i32 %le40, 10
  store i32 %Asn41, i32* %div
  %9 = load i32, i32* %div
  br label %block_end28

merge25:                                          ; preds = %while23
  br label %block_end

block_end28:                                      ; preds = %while_body24
  br label %while23
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
  %digits5 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 5
  %y6 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %x7 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 8
  %x8 = load i32, i32* %x2
  %this9 = load %objref, %objref* %this1
  %objptr_gen10 = extractvalue %objref %this9, 1
  %objptr11 = bitcast %gameobj* %objptr_gen10 to %Draw*
  %digits12 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 2
  %n13 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 3
  %height14 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 4
  %width15 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 5
  %y16 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 6
  %x17 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 7
  %spr18 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 8
  store i32 %x8, i32* %x17
  %0 = load i32, i32* %x17
  %y19 = load i32, i32* %y3
  %this20 = load %objref, %objref* %this1
  %objptr_gen21 = extractvalue %objref %this20, 1
  %objptr22 = bitcast %gameobj* %objptr_gen21 to %Draw*
  %digits23 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 2
  %n24 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 3
  %height25 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 4
  %width26 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 5
  %y27 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 6
  %x28 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 7
  %spr29 = getelementptr inbounds %Draw, %Draw* %objptr22, i32 0, i32 8
  store i32 %y19, i32* %y27
  %1 = load i32, i32* %y27
  %digits30 = load i32, i32* %digits4
  %this31 = load %objref, %objref* %this1
  %objptr_gen32 = extractvalue %objref %this31, 1
  %objptr33 = bitcast %gameobj* %objptr_gen32 to %Draw*
  %digits34 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 2
  %n35 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 3
  %height36 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 4
  %width37 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 5
  %y38 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 6
  %x39 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 7
  %spr40 = getelementptr inbounds %Draw, %Draw* %objptr33, i32 0, i32 8
  store i32 %digits30, i32* %digits34
  %2 = load i32, i32* %digits34
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
  %digits = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 5
  %y = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %x = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 8
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
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %draw_x = alloca double
  %x2 = load i32, i32* %x
  %0 = sitofp i32 %x2 to double
  store double %0, double* %draw_x
  %draw_y = alloca double
  %y3 = load i32, i32* %y
  %1 = sitofp i32 %y3 to double
  store double %1, double* %draw_y
  %piece4 = load %objref, %objref* %piece
  %tmp_lid = extractvalue %objref %piece4, 0
  %tmp = icmp ne i64 %tmp_lid, 0
  br i1 %tmp, label %then, label %else55

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end56, %block_end5
  %le = load double, double* %draw_x
  %tile_size = load i32, i32* @"variable::tile_size"
  %2 = sitofp i32 %tile_size to double
  %Asn = fmul double %le, %2
  store double %Asn, double* %draw_x
  %3 = load double, double* %draw_x
  %le57 = load double, double* %draw_y
  %tile_size58 = load i32, i32* @"variable::tile_size"
  %4 = sitofp i32 %tile_size58 to double
  %Asn59 = fmul double %le57, %4
  store double %Asn59, double* %draw_y
  %5 = load double, double* %draw_y
  %le60 = load double, double* %draw_x
  %boardOffsetX = load i32, i32* @"variable::boardOffsetX"
  %6 = sitofp i32 %boardOffsetX to double
  %Asn61 = fadd double %le60, %6
  store double %Asn61, double* %draw_x
  %7 = load double, double* %draw_x
  %le62 = load double, double* %draw_y
  %boardOffsetY = load i32, i32* @"variable::boardOffsetY"
  %8 = sitofp i32 %boardOffsetY to double
  %Asn63 = fadd double %le62, %8
  store double %Asn63, double* %draw_y
  %9 = load double, double* %draw_y
  %s64 = load %sfSprite*, %sfSprite** %s
  %draw_x65 = load double, double* %draw_x
  %draw_y66 = load double, double* %draw_y
  %type_rect67 = load [4 x i32], [4 x i32]* %type_rect
  call void @"function:file-../../lib/sprite.mg::render_rect"(%sfSprite* %s64, double %draw_x65, double %draw_y66, [4 x i32] %type_rect67)
  br label %block_end

then:                                             ; preds = %entry
  %piece6 = load %objref, %objref* %piece
  %objptr_gen7 = extractvalue %objref %piece6, 1
  %objptr8 = bitcast %gameobj* %objptr_gen7 to %Piece*
  %next = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 8
  %y9 = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 9
  %x10 = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr8, i32 0, i32 12
  %active11 = load i1, i1* %active
  %tmp12 = xor i1 %active11, true
  br i1 %tmp12, label %then14, label %else

block_end5:                                       ; preds = %merge13
  br label %merge

merge13:                                          ; preds = %block_end20, %block_end15
  br label %block_end5

then14:                                           ; preds = %then
  %x16 = load i32, i32* %x
  %10 = sitofp i32 %x16 to double
  %tmp17 = fadd double %10, 1.350000e+01
  store double %tmp17, double* %draw_x
  %11 = load double, double* %draw_x
  %y18 = load i32, i32* %y
  %tmp19 = add i32 %y18, 9
  %12 = sitofp i32 %tmp19 to double
  store double %12, double* %draw_y
  %13 = load double, double* %draw_y
  br label %block_end15

block_end15:                                      ; preds = %then14
  br label %merge13

else:                                             ; preds = %then
  %x21 = load i32, i32* %x
  %piece22 = load %objref, %objref* %piece
  %objptr_gen23 = extractvalue %objref %piece22, 1
  %objptr24 = bitcast %gameobj* %objptr_gen23 to %Piece*
  %next25 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 2
  %hard_drop26 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 3
  %piece_type27 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 4
  %active28 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 5
  %drop_points29 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 6
  %horiz_timer30 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 7
  %curr_timer31 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 8
  %y32 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 9
  %x33 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 10
  %board34 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 11
  %blocks35 = getelementptr inbounds %Piece, %Piece* %objptr24, i32 0, i32 12
  %x36 = load i32, i32* %x33
  %tmp37 = add i32 %x21, %x36
  %14 = sitofp i32 %tmp37 to double
  store double %14, double* %draw_x
  %15 = load double, double* %draw_x
  %y38 = load i32, i32* %y
  %piece39 = load %objref, %objref* %piece
  %objptr_gen40 = extractvalue %objref %piece39, 1
  %objptr41 = bitcast %gameobj* %objptr_gen40 to %Piece*
  %next42 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 2
  %hard_drop43 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 3
  %piece_type44 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 4
  %active45 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 5
  %drop_points46 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 6
  %horiz_timer47 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 7
  %curr_timer48 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 8
  %y49 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 9
  %x50 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 10
  %board51 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 11
  %blocks52 = getelementptr inbounds %Piece, %Piece* %objptr41, i32 0, i32 12
  %y53 = load i32, i32* %y49
  %tmp54 = add i32 %y38, %y53
  %16 = sitofp i32 %tmp54 to double
  store double %16, double* %draw_y
  %17 = load double, double* %draw_y
  br label %block_end20

block_end20:                                      ; preds = %else
  br label %merge13

else55:                                           ; preds = %entry
  br label %block_end56

block_end56:                                      ; preds = %else55
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
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %y5 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %x6 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @literal.7, i32 0, i32 0))
  store %sfSprite* %load_result, %sfSprite** %s
  %0 = load %sfSprite*, %sfSprite** %s
  %x7 = load i32, i32* %x2
  %this8 = load %objref, %objref* %this1
  %objptr_gen9 = extractvalue %objref %this8, 1
  %objptr10 = bitcast %gameobj* %objptr_gen9 to %Block*
  %piece11 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 2
  %s12 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 3
  %type_rect13 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 4
  %type_y14 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 5
  %type_x15 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 6
  %y16 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 7
  %x17 = getelementptr inbounds %Block, %Block* %objptr10, i32 0, i32 8
  store i32 %x7, i32* %x17
  %1 = load i32, i32* %x17
  %y18 = load i32, i32* %y3
  %this19 = load %objref, %objref* %this1
  %objptr_gen20 = extractvalue %objref %this19, 1
  %objptr21 = bitcast %gameobj* %objptr_gen20 to %Block*
  %piece22 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 2
  %s23 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 3
  %type_rect24 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 4
  %type_y25 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 5
  %type_x26 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 6
  %y27 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 7
  %x28 = getelementptr inbounds %Block, %Block* %objptr21, i32 0, i32 8
  store i32 %y18, i32* %y27
  %2 = load i32, i32* %y27
  %p29 = load %objref, %objref* %p4
  store %objref %p29, %objref* %piece
  %3 = load %objref, %objref* %piece
  %this30 = load %objref, %objref* %this1
  call void @"object::Block.function.setType"(%objref %this30, i32 0, i32 0)
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
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %piece3 = load %objref, %objref* %piece
  %objptr_gen4 = extractvalue %objref %piece3, 1
  %objptr5 = bitcast %gameobj* %objptr_gen4 to %Piece*
  %next = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 8
  %y6 = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 9
  %x7 = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 10
  %board8 = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr5, i32 0, i32 12
  %x9 = load i32, i32* %x7
  %x10 = load i32, i32* %x
  %tmp = add i32 %x9, %x10
  store i32 %tmp, i32* %x
  %0 = load i32, i32* %x
  %piece11 = load %objref, %objref* %piece
  %objptr_gen12 = extractvalue %objref %piece11, 1
  %objptr13 = bitcast %gameobj* %objptr_gen12 to %Piece*
  %next14 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 2
  %hard_drop15 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 3
  %piece_type16 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 4
  %active17 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 5
  %drop_points18 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 6
  %horiz_timer19 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 7
  %curr_timer20 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 8
  %y21 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 9
  %x22 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 10
  %board23 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 11
  %blocks24 = getelementptr inbounds %Piece, %Piece* %objptr13, i32 0, i32 12
  %y25 = load i32, i32* %y21
  %y26 = load i32, i32* %y
  %tmp27 = add i32 %y25, %y26
  store i32 %tmp27, i32* %y
  %1 = load i32, i32* %y
  store %objref zeroinitializer, %objref* %piece
  %2 = load %objref, %objref* %piece
  %y28 = load i32, i32* %y
  %tmp29 = icmp sle i32 %y28, 0
  br i1 %tmp29, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end38, %block_end30
  %this39 = load %objref, %objref* %this1
  %board40 = load %objref, %objref* %board2
  %objptr_gen41 = extractvalue %objref %board40, 1
  %objptr42 = bitcast %gameobj* %objptr_gen41 to %Board*
  %pieces = getelementptr inbounds %Board, %Board* %objptr42, i32 0, i32 2
  %y43 = load i32, i32* %y
  %subscript = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces, i32 0, i32 %y43
  %x44 = load i32, i32* %x
  %subscript45 = getelementptr [10 x %objref], [10 x %objref]* %subscript, i32 0, i32 %x44
  store %objref %this39, %objref* %subscript45
  %3 = load %objref, %objref* %subscript45
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
  %marker31 = getelementptr inbounds %node, %node* %room_objnode, i32 0, i32 2
  store i1 true, i1* %marker31
  call void @list_add(%node* %room_objnode, %node* @"node.object:file-../../lib/game.mg::room.head")
  %room_parent = getelementptr inbounds %room, %room* %game_over_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 1
  %marker32 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker32
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
  %objptr_gen33 = extractvalue %objref %score_count, 1
  %objptr34 = bitcast %gameobj* %objptr_gen33 to %Draw*
  %digits = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 5
  %y35 = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 6
  %x36 = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr34, i32 0, i32 8
  %n37 = load i32, i32* %n
  call void @"object::game_over.event.create"(%objref %7, i32 %n37)
  ret void

block_end30:                                      ; preds = %postret
  br label %merge

postret:                                          ; No predecessors!
  br label %block_end30

else:                                             ; preds = %entry
  br label %block_end38

block_end38:                                      ; preds = %else
  br label %merge
}

define void @"object::Block.function.rotateRight"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Block*
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
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
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %newX = alloca i32
  %y2 = load i32, i32* %y
  %tmp = sub i32 0, %y2
  store i32 %tmp, i32* %newX
  %newY = alloca i32
  %x3 = load i32, i32* %x
  store i32 %x3, i32* %newY
  %newY4 = load i32, i32* %newY
  store i32 %newY4, i32* %y
  %0 = load i32, i32* %y
  %newX5 = load i32, i32* %newX
  store i32 %newX5, i32* %x
  %1 = load i32, i32* %x
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
  %piece = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 6
  %y4 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 7
  %x5 = getelementptr inbounds %Block, %Block* %objptr, i32 0, i32 8
  %x6 = load i32, i32* %x2
  store i32 %x6, i32* %type_x
  %0 = load i32, i32* %type_x
  %y7 = load i32, i32* %y3
  store i32 %y7, i32* %type_y
  %1 = load i32, i32* %type_y
  %tile_size = load i32, i32* @"variable::tile_size"
  %x8 = load i32, i32* %x2
  %tmp = mul i32 %tile_size, %x8
  %tile_size9 = load i32, i32* @"variable::tile_size"
  %y10 = load i32, i32* %y3
  %tmp11 = mul i32 %tile_size9, %y10
  %tile_size12 = load i32, i32* @"variable::tile_size"
  %tile_size13 = load i32, i32* @"variable::tile_size"
  %2 = insertvalue [4 x i32] undef, i32 %tmp, 0
  %3 = insertvalue [4 x i32] %2, i32 %tmp11, 1
  %4 = insertvalue [4 x i32] %3, i32 %tile_size12, 2
  %5 = insertvalue [4 x i32] %4, i32 %tile_size13, 3
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %active2 = load i1, i1* %active
  %tmp = xor i1 %active2, true
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge85
  ret void

merge:                                            ; preds = %block_end3, %postret
  %Left = load i32, i32* @"variable:file-../../lib/key.mg::Left"
  %is_pressed_result = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Left)
  %Left4 = load i32, i32* @"variable:file-../../lib/key.mg::Left"
  %is_down_result = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Left4)
  %horiz_timer5 = load i32, i32* %horiz_timer
  %tmp6 = icmp eq i32 %horiz_timer5, 0
  %tmp7 = and i1 %is_down_result, %tmp6
  %tmp8 = or i1 %is_pressed_result, %tmp7
  br i1 %tmp8, label %then10, label %else13

then:                                             ; preds = %entry
  ret void

postret:                                          ; No predecessors!
  br label %merge

else:                                             ; preds = %entry
  br label %block_end3

block_end3:                                       ; preds = %else
  br label %merge

merge9:                                           ; preds = %block_end14, %block_end11
  %Right = load i32, i32* @"variable:file-../../lib/key.mg::Right"
  %is_pressed_result15 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Right)
  %Right16 = load i32, i32* @"variable:file-../../lib/key.mg::Right"
  %is_down_result17 = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Right16)
  %horiz_timer18 = load i32, i32* %horiz_timer
  %tmp19 = icmp eq i32 %horiz_timer18, 0
  %tmp20 = and i1 %is_down_result17, %tmp19
  %tmp21 = or i1 %is_pressed_result15, %tmp20
  br i1 %tmp21, label %then23, label %else26

then10:                                           ; preds = %merge
  store i32 5, i32* %horiz_timer
  %0 = load i32, i32* %horiz_timer
  %this12 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveLeft"(%objref %this12)
  br label %block_end11

block_end11:                                      ; preds = %then10
  br label %merge9

else13:                                           ; preds = %merge
  br label %block_end14

block_end14:                                      ; preds = %else13
  br label %merge9

merge22:                                          ; preds = %block_end27, %block_end24
  %Down = load i32, i32* @"variable:file-../../lib/key.mg::Down"
  %is_down_result28 = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Down)
  br i1 %is_down_result28, label %then30, label %else39

then23:                                           ; preds = %merge9
  store i32 5, i32* %horiz_timer
  %1 = load i32, i32* %horiz_timer
  %this25 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveRight"(%objref %this25)
  br label %block_end24

block_end24:                                      ; preds = %then23
  br label %merge22

else26:                                           ; preds = %merge9
  br label %block_end27

block_end27:                                      ; preds = %else26
  br label %merge22

merge29:                                          ; preds = %block_end40, %block_end31
  %X = load i32, i32* @"variable:file-../../lib/key.mg::X"
  %is_pressed_result41 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %X)
  br i1 %is_pressed_result41, label %then43, label %else45

then30:                                           ; preds = %merge22
  %curr_timer32 = load i32, i32* %curr_timer
  %tmp33 = icmp sgt i32 %curr_timer32, 3
  br i1 %tmp33, label %then35, label %else37

block_end31:                                      ; preds = %merge34
  br label %merge29

merge34:                                          ; preds = %block_end38, %block_end36
  br label %block_end31

then35:                                           ; preds = %then30
  store i32 3, i32* %curr_timer
  %2 = load i32, i32* %curr_timer
  %le = load i32, i32* %drop_points
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %drop_points
  %3 = load i32, i32* %drop_points
  br label %block_end36

block_end36:                                      ; preds = %then35
  br label %merge34

else37:                                           ; preds = %then30
  br label %block_end38

block_end38:                                      ; preds = %else37
  br label %merge34

else39:                                           ; preds = %merge22
  br label %block_end40

block_end40:                                      ; preds = %else39
  br label %merge29

merge42:                                          ; preds = %block_end46, %then43
  %Z = load i32, i32* @"variable:file-../../lib/key.mg::Z"
  %is_pressed_result47 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Z)
  br i1 %is_pressed_result47, label %then49, label %else51

then43:                                           ; preds = %merge29
  %this44 = load %objref, %objref* %this1
  call void @"object::Piece.function.rotateLeft"(%objref %this44)
  br label %merge42

else45:                                           ; preds = %merge29
  br label %block_end46

block_end46:                                      ; preds = %else45
  br label %merge42

merge48:                                          ; preds = %block_end52, %then49
  %Space = load i32, i32* @"variable:file-../../lib/key.mg::Space"
  %is_pressed_result53 = call i1 @"function:file-../../lib/key.mg::is_pressed"(i32 %Space)
  %hard_drop54 = load i32, i32* %hard_drop
  %tmp55 = icmp eq i32 %hard_drop54, 0
  %tmp56 = and i1 %is_pressed_result53, %tmp55
  br i1 %tmp56, label %then58, label %else65

then49:                                           ; preds = %merge42
  %this50 = load %objref, %objref* %this1
  call void @"object::Piece.function.rotateRight"(%objref %this50)
  br label %merge48

else51:                                           ; preds = %merge42
  br label %block_end52

block_end52:                                      ; preds = %else51
  br label %merge48

merge57:                                          ; preds = %block_end66, %merge59
  %le67 = load i32, i32* %curr_timer
  %Asn68 = sub i32 %le67, 1
  store i32 %Asn68, i32* %curr_timer
  %4 = load i32, i32* %curr_timer
  %tmp69 = icmp eq i32 %4, 0
  br i1 %tmp69, label %then71, label %else73

then58:                                           ; preds = %merge48
  br label %while

while:                                            ; preds = %block_end61, %then58
  %active60 = load i1, i1* %active
  br i1 %active60, label %while_body, label %merge59

while_body:                                       ; preds = %while
  %le62 = load i32, i32* %drop_points
  %Asn63 = add i32 %le62, 1
  store i32 %Asn63, i32* %drop_points
  %5 = load i32, i32* %drop_points
  %this64 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveDown"(%objref %this64)
  br label %block_end61

merge59:                                          ; preds = %while
  br label %merge57

block_end61:                                      ; preds = %while_body
  br label %while

else65:                                           ; preds = %merge48
  br label %block_end66

block_end66:                                      ; preds = %else65
  br label %merge57

merge70:                                          ; preds = %block_end74, %then71
  %horiz_timer75 = load i32, i32* %horiz_timer
  %tmp76 = icmp sgt i32 %horiz_timer75, 0
  br i1 %tmp76, label %then78, label %else81

then71:                                           ; preds = %merge57
  %this72 = load %objref, %objref* %this1
  call void @"object::Piece.function.moveDown"(%objref %this72)
  br label %merge70

else73:                                           ; preds = %merge57
  br label %block_end74

block_end74:                                      ; preds = %else73
  br label %merge70

merge77:                                          ; preds = %block_end82, %then78
  %hard_drop83 = load i32, i32* %hard_drop
  %tmp84 = icmp sgt i32 %hard_drop83, 0
  br i1 %tmp84, label %then86, label %else89

then78:                                           ; preds = %merge70
  %le79 = load i32, i32* %horiz_timer
  %Asn80 = sub i32 %le79, 1
  store i32 %Asn80, i32* %horiz_timer
  %6 = load i32, i32* %horiz_timer
  br label %merge77

else81:                                           ; preds = %merge70
  br label %block_end82

block_end82:                                      ; preds = %else81
  br label %merge77

merge85:                                          ; preds = %block_end90, %then86
  br label %block_end

then86:                                           ; preds = %merge77
  %le87 = load i32, i32* %hard_drop
  %Asn88 = sub i32 %le87, 1
  store i32 %Asn88, i32* %hard_drop
  %7 = load i32, i32* %hard_drop
  br label %merge85

else89:                                           ; preds = %merge77
  br label %block_end90

block_end90:                                      ; preds = %else89
  br label %merge85
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  store i32 0, i32* %drop_points
  %0 = load i32, i32* %drop_points
  %b3 = load %objref, %objref* %b2
  store %objref %b3, %objref* %board
  %1 = load %objref, %objref* %board
  %current_speed_result = call i32 @"function::current_speed"()
  store i32 %current_speed_result, i32* %curr_timer
  %2 = load i32, i32* %curr_timer
  store i1 false, i1* %active
  %3 = load i1, i1* %active
  store i32 1, i32* %hard_drop
  %4 = load i32, i32* %hard_drop
  %piece_type_x = alloca i32
  %irandom_result = call i32 @"function:file-../../lib/math.mg::irandom"(i32 3)
  store i32 %irandom_result, i32* %piece_type_x
  %piece_type_y = alloca i32
  %irandom_result4 = call i32 @"function:file-../../lib/math.mg::irandom"(i32 10)
  store i32 %irandom_result4, i32* %piece_type_y
  %irandom_result5 = call i32 @"function:file-../../lib/math.mg::irandom"(i32 7)
  store i32 %irandom_result5, i32* %piece_type
  %5 = load i32, i32* %piece_type
  %k = alloca i32
  store i32 0, i32* %k
  %y7 = alloca i32
  store i32 0, i32* %y7
  br label %while

block_end:                                        ; preds = %block_end6
  ret void

block_end6:                                       ; preds = %merge
  br label %block_end

while:                                            ; preds = %block_end9, %entry
  %y8 = load i32, i32* %y7
  %tmp = icmp slt i32 %y8, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %x11 = alloca i32
  store i32 0, i32* %x11
  br label %while12

merge:                                            ; preds = %while
  br label %block_end6

block_end9:                                       ; preds = %block_end10
  br label %while

block_end10:                                      ; preds = %merge14
  %le44 = load i32, i32* %y7
  %Asn45 = add i32 %le44, 1
  store i32 %Asn45, i32* %y7
  %6 = load i32, i32* %y7
  br label %block_end9

while12:                                          ; preds = %block_end17, %while_body
  %x15 = load i32, i32* %x11
  %tmp16 = icmp slt i32 %x15, 3
  br i1 %tmp16, label %while_body13, label %merge14

while_body13:                                     ; preds = %while12
  %x18 = load i32, i32* %x11
  %y19 = load i32, i32* %y7
  %piece_type20 = load i32, i32* %piece_type
  %possible_pieces = load [7 x [4 x [3 x i1]]], [7 x [4 x [3 x i1]]]* @"variable::possible_pieces"
  %arr = alloca [7 x [4 x [3 x i1]]]
  store [7 x [4 x [3 x i1]]] %possible_pieces, [7 x [4 x [3 x i1]]]* %arr
  %7 = getelementptr [7 x [4 x [3 x i1]]], [7 x [4 x [3 x i1]]]* %arr, i32 0, i32 %piece_type20
  %subscript = load [4 x [3 x i1]], [4 x [3 x i1]]* %7
  %arr21 = alloca [4 x [3 x i1]]
  store [4 x [3 x i1]] %subscript, [4 x [3 x i1]]* %arr21
  %8 = getelementptr [4 x [3 x i1]], [4 x [3 x i1]]* %arr21, i32 0, i32 %y19
  %subscript22 = load [3 x i1], [3 x i1]* %8
  %arr23 = alloca [3 x i1]
  store [3 x i1] %subscript22, [3 x i1]* %arr23
  %9 = getelementptr [3 x i1], [3 x i1]* %arr23, i32 0, i32 %x18
  %subscript24 = load i1, i1* %9
  br i1 %subscript24, label %then, label %else

merge14:                                          ; preds = %while12
  br label %block_end10

block_end17:                                      ; preds = %merge25
  br label %while12

merge25:                                          ; preds = %block_end41, %block_end26
  %le42 = load i32, i32* %x11
  %Asn43 = add i32 %le42, 1
  store i32 %Asn43, i32* %x11
  %10 = load i32, i32* %x11
  br label %block_end17

then:                                             ; preds = %while_body13
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
  %marker27 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker27
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
  %x28 = load i32, i32* %x11
  %tmp29 = sub i32 %x28, 1
  %y30 = load i32, i32* %y7
  %tmp31 = sub i32 %y30, 1
  %this32 = load %objref, %objref* %this1
  call void @"object::Block.event.create"(%objref %14, i32 %tmp29, i32 %tmp31, %objref %this32)
  %k33 = load i32, i32* %k
  %subscript34 = getelementptr [4 x %objref], [4 x %objref]* %blocks, i32 0, i32 %k33
  store %objref %14, %objref* %subscript34
  %15 = load %objref, %objref* %subscript34
  %k35 = load i32, i32* %k
  %blocks36 = load [4 x %objref], [4 x %objref]* %blocks
  %arr37 = alloca [4 x %objref]
  store [4 x %objref] %blocks36, [4 x %objref]* %arr37
  %16 = getelementptr [4 x %objref], [4 x %objref]* %arr37, i32 0, i32 %k35
  %subscript38 = load %objref, %objref* %16
  %piece_type_x39 = load i32, i32* %piece_type_x
  %piece_type_y40 = load i32, i32* %piece_type_y
  call void @"object::Block.function.setType"(%objref %subscript38, i32 %piece_type_x39, i32 %piece_type_y40)
  %le = load i32, i32* %k
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %k
  %17 = load i32, i32* %k
  br label %block_end26

block_end26:                                      ; preds = %then
  br label %merge25

else:                                             ; preds = %while_body13
  br label %block_end41

block_end41:                                      ; preds = %else
  br label %merge25
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %merge31
  ret void

block_end2:                                       ; preds = %merge
  %drop = load %sfSound*, %sfSound** @"variable::snds::drop"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %drop)
  %board17 = load %objref, %objref* %board
  call void @"object::Board.function.checkRows"(%objref %board17)
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
  %digits = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 5
  %y24 = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 6
  %x25 = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 8
  %le26 = load i32, i32* %n
  %drop_points27 = load i32, i32* %drop_points
  %Asn28 = add i32 %le26, %drop_points27
  store i32 %Asn28, i32* %n
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
  br label %while29

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %i6 = load i32, i32* %i
  %blocks7 = load [4 x %objref], [4 x %objref]* %blocks
  %arr = alloca [4 x %objref]
  store [4 x %objref] %blocks7, [4 x %objref]* %arr
  %4 = getelementptr [4 x %objref], [4 x %objref]* %arr, i32 0, i32 %i6
  %subscript = load %objref, %objref* %4
  %board8 = load %objref, %objref* %board
  call void @"object::Block.function.settlePosition"(%objref %subscript, %objref %board8)
  %i9 = load i32, i32* %i
  %blocks10 = load [4 x %objref], [4 x %objref]* %blocks
  %arr11 = alloca [4 x %objref]
  store [4 x %objref] %blocks10, [4 x %objref]* %arr11
  %5 = getelementptr [4 x %objref], [4 x %objref]* %arr11, i32 0, i32 %i9
  %subscript12 = load %objref, %objref* %5
  %objptr_gen13 = extractvalue %objref %subscript12, 1
  %objptr14 = bitcast %gameobj* %objptr_gen13 to %Block*
  %piece = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 6
  %y15 = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 7
  %x16 = getelementptr inbounds %Block, %Block* %objptr14, i32 0, i32 8
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

while29:                                          ; preds = %merge35, %block_end2
  %curr = load %node*, %node** %next_ptr
  %8 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next32 = load %node*, %node** %8
  %9 = ptrtoint %node* %curr to i64
  %10 = ptrtoint %node* %next32 to i64
  %11 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next32, %node** %next_ptr
  %cont = icmp ne %node* %curr, @"node.object::game_over.head"
  br i1 %cont, label %while_body30, label %merge31

while_body30:                                     ; preds = %while29
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker33 = load i1, i1* %markerptr
  %cont34 = icmp eq i1 %marker33, true
  br i1 %cont34, label %then, label %else41

merge31:                                          ; preds = %while29
  call void @list_rem(%node* %tail)
  %next46 = load %objref, %objref* %next
  call void @"object::Piece.function.activate"(%objref %next46)
  %drop47 = load %sfSound*, %sfSound** @"variable::snds::drop"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %drop47)
  br label %block_end

merge35:                                          ; preds = %merge43, %merge37
  br label %while29

then:                                             ; preds = %while_body30
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%game_over, %game_over* null, i32 0, i32 1) to i64)
  %game_over = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %game_over, i32 0, i32 2
  %id36 = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id36, 0
  br i1 %is_removed, label %then38, label %else

merge37:                                          ; preds = %else, %block_end40
  br label %merge35

then38:                                           ; preds = %then
  %12 = getelementptr inbounds %gameobj, %gameobj* %game_over, i32 0, i32 2
  %id39 = load i64, i64* %12
  %13 = insertvalue %objref undef, i64 %id39, 0
  %14 = insertvalue %objref %13, %gameobj* %game_over, 1
  %ref = alloca %objref
  store %objref %14, %objref* %ref
  ret void

block_end40:                                      ; preds = %postret
  br label %merge37

postret:                                          ; No predecessors!
  br label %block_end40

else:                                             ; preds = %then
  br label %merge37

else41:                                           ; preds = %while_body30
  %cont42 = icmp eq %node* %curr, %tail
  br i1 %cont42, label %then44, label %else45

merge43:                                          ; preds = %else45, %then44
  br label %merge35

then44:                                           ; preds = %else41
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @"node.object::game_over.head")
  br label %merge43

else45:                                           ; preds = %else41
  br label %merge43
}

define void @"object::Piece.function.moveDown"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %current_speed_result = call i32 @"function::current_speed"()
  store i32 %current_speed_result, i32* %curr_timer
  %0 = load i32, i32* %curr_timer
  %le = load i32, i32* %y
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %y
  %1 = load i32, i32* %y
  %this2 = load %objref, %objref* %this1
  %isColliding_result = call i1 @"object::Piece.function.isColliding"(%objref %this2)
  br i1 %isColliding_result, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end7, %block_end3
  br label %block_end

then:                                             ; preds = %entry
  %le4 = load i32, i32* %y
  %Asn5 = sub i32 %le4, 1
  store i32 %Asn5, i32* %y
  %2 = load i32, i32* %y
  %this6 = load %objref, %objref* %this1
  call void @"object::Piece.function.settlePosition"(%objref %this6)
  br label %block_end3

block_end3:                                       ; preds = %then
  br label %merge

else:                                             ; preds = %entry
  br label %block_end7

block_end7:                                       ; preds = %else
  br label %merge
}

define void @"object::Piece.function.moveRight"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
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
  %le3 = load i32, i32* %x
  %Asn4 = sub i32 %le3, 1
  store i32 %Asn4, i32* %x
  %1 = load i32, i32* %x
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
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
  %le3 = load i32, i32* %x
  %Asn4 = add i32 %le3, 1
  store i32 %Asn4, i32* %x
  %1 = load i32, i32* %x
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
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
  %blocks18 = load [4 x %objref], [4 x %objref]* %blocks
  %arr19 = alloca [4 x %objref]
  store [4 x %objref] %blocks18, [4 x %objref]* %arr19
  %2 = getelementptr [4 x %objref], [4 x %objref]* %arr19, i32 0, i32 %i17
  %subscript20 = load %objref, %objref* %2
  call void @"object::Block.function.rotateLeft"(%objref %subscript20)
  %le21 = load i32, i32* %i10
  %Asn22 = add i32 %le21, 1
  store i32 %Asn22, i32* %i10
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
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
  %blocks18 = load [4 x %objref], [4 x %objref]* %blocks
  %arr19 = alloca [4 x %objref]
  store [4 x %objref] %blocks18, [4 x %objref]* %arr19
  %2 = getelementptr [4 x %objref], [4 x %objref]* %arr19, i32 0, i32 %i17
  %subscript20 = load %objref, %objref* %2
  call void @"object::Block.function.rotateRight"(%objref %subscript20)
  %le21 = load i32, i32* %i10
  %Asn22 = add i32 %le21, 1
  store i32 %Asn22, i32* %i10
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
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %i = alloca i32
  store i32 0, i32* %i
  br label %while

block_end:                                        ; preds = %postret33
  ret i1 false

block_end2:                                       ; preds = %merge
  ret i1 false

while:                                            ; preds = %block_end4, %entry
  %i3 = load i32, i32* %i
  %tmp = icmp slt i32 %i3, 4
  br i1 %tmp, label %while_body, label %merge

while_body:                                       ; preds = %while
  %board5 = load %objref, %objref* %board
  %i6 = load i32, i32* %i
  %blocks7 = load [4 x %objref], [4 x %objref]* %blocks
  %arr = alloca [4 x %objref]
  store [4 x %objref] %blocks7, [4 x %objref]* %arr
  %0 = getelementptr [4 x %objref], [4 x %objref]* %arr, i32 0, i32 %i6
  %subscript = load %objref, %objref* %0
  %objptr_gen8 = extractvalue %objref %subscript, 1
  %objptr9 = bitcast %gameobj* %objptr_gen8 to %Block*
  %piece = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 6
  %y10 = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 7
  %x11 = getelementptr inbounds %Block, %Block* %objptr9, i32 0, i32 8
  %x12 = load i32, i32* %x11
  %x13 = load i32, i32* %x
  %tmp14 = add i32 %x12, %x13
  %i15 = load i32, i32* %i
  %blocks16 = load [4 x %objref], [4 x %objref]* %blocks
  %arr17 = alloca [4 x %objref]
  store [4 x %objref] %blocks16, [4 x %objref]* %arr17
  %1 = getelementptr [4 x %objref], [4 x %objref]* %arr17, i32 0, i32 %i15
  %subscript18 = load %objref, %objref* %1
  %objptr_gen19 = extractvalue %objref %subscript18, 1
  %objptr20 = bitcast %gameobj* %objptr_gen19 to %Block*
  %piece21 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 2
  %s22 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 3
  %type_rect23 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 4
  %type_y24 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 5
  %type_x25 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 6
  %y26 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 7
  %x27 = getelementptr inbounds %Block, %Block* %objptr20, i32 0, i32 8
  %y28 = load i32, i32* %y26
  %y29 = load i32, i32* %y
  %tmp30 = add i32 %y28, %y29
  %occupied_result = call i1 @"object::Board.function.occupied"(%objref %board5, i32 %tmp14, i32 %tmp30)
  br i1 %occupied_result, label %then, label %else

merge:                                            ; preds = %while
  br label %block_end2

block_end4:                                       ; preds = %merge31
  br label %while

merge31:                                          ; preds = %block_end32, %postret
  %le = load i32, i32* %i
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %i
  %2 = load i32, i32* %i
  br label %block_end4

then:                                             ; preds = %while_body
  ret i1 true

postret:                                          ; No predecessors!
  br label %merge31

else:                                             ; preds = %while_body
  br label %block_end32

block_end32:                                      ; preds = %else
  br label %merge31

postret33:                                        ; No predecessors!
  br label %block_end
}

define void @"object::Piece.function.activate"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Piece*
  %next = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 2
  %hard_drop = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 3
  %piece_type = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 4
  %active = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 5
  %drop_points = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 6
  %horiz_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 7
  %curr_timer = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 8
  %y = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 9
  %x = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 10
  %board = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 11
  %blocks = getelementptr inbounds %Piece, %Piece* %objptr, i32 0, i32 12
  %piece_type2 = load i32, i32* %piece_type
  %piece_counts = load [7 x %objref], [7 x %objref]* @"variable::piece_counts"
  %arr = alloca [7 x %objref]
  store [7 x %objref] %piece_counts, [7 x %objref]* %arr
  %0 = getelementptr [7 x %objref], [7 x %objref]* %arr, i32 0, i32 %piece_type2
  %subscript = load %objref, %objref* %0
  %objptr_gen3 = extractvalue %objref %subscript, 1
  %objptr4 = bitcast %gameobj* %objptr_gen3 to %Draw*
  %digits = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 5
  %y5 = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 6
  %x6 = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 8
  %le = load i32, i32* %n
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %n
  %1 = load i32, i32* %n
  store i1 true, i1* %active
  %2 = load i1, i1* %active
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
  %marker7 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker7
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
  %board8 = load %objref, %objref* %board
  call void @"object::Piece.event.create"(%objref %6, %objref %board8)
  store %objref %6, %objref* %next
  %7 = load %objref, %objref* %next
  store i32 5, i32* %x
  %8 = load i32, i32* %x
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
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
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
  %y12 = load i32, i32* %y
  %subscript = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces, i32 0, i32 %y12
  %x13 = load i32, i32* %x
  %subscript14 = getelementptr [10 x %objref], [10 x %objref]* %subscript, i32 0, i32 %x13
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
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
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
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
  %x = alloca i32
  store i32 0, i32* %x
  br label %while

block_end:                                        ; preds = %postret191
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
  %r36 = load i32, i32* %r2
  store i32 %r36, i32* %y
  br label %while37

while16:                                          ; preds = %block_end22, %block_end3
  %x19 = load i32, i32* %x15
  %board_width20 = load i32, i32* @"variable::board_width"
  %tmp21 = icmp slt i32 %x19, %board_width20
  br i1 %tmp21, label %while_body17, label %merge18

while_body17:                                     ; preds = %while16
  %x23 = load i32, i32* %x15
  %r24 = load i32, i32* %r2
  %pieces25 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces
  %arr26 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces25, [24 x [10 x %objref]]* %arr26
  %3 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr26, i32 0, i32 %r24
  %subscript27 = load [10 x %objref], [10 x %objref]* %3
  %arr28 = alloca [10 x %objref]
  store [10 x %objref] %subscript27, [10 x %objref]* %arr28
  %4 = getelementptr [10 x %objref], [10 x %objref]* %arr28, i32 0, i32 %x23
  %subscript29 = load %objref, %objref* %4
  %objptr30 = extractvalue %objref %subscript29, 1
  %5 = bitcast %gameobj* %objptr30 to { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }**
  %tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %5
  %eventptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 3
  %event = load void (%objref)*, void (%objref)** %eventptr
  %eventptr31 = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 1
  %event32 = load void (%objref)*, void (%objref)** %eventptr31
  call void %event32(%objref %subscript29)
  call void %event(%objref %subscript29)
  %id = getelementptr inbounds %gameobj, %gameobj* %objptr30, i32 0, i32 2
  store i64 0, i64* %id
  %le33 = load i32, i32* %x15
  %Asn34 = add i32 %le33, 1
  store i32 %Asn34, i32* %x15
  %6 = load i32, i32* %x15
  br label %block_end22

merge18:                                          ; preds = %while16
  br label %block_end14

block_end22:                                      ; preds = %while_body17
  br label %while16

block_end35:                                      ; preds = %merge39
  %x96 = alloca i32
  store i32 0, i32* %x96
  br label %while97

while37:                                          ; preds = %block_end42, %block_end14
  %y40 = load i32, i32* %y
  %tmp41 = icmp sgt i32 %y40, 0
  br i1 %tmp41, label %while_body38, label %merge39

while_body38:                                     ; preds = %while37
  %x44 = alloca i32
  store i32 0, i32* %x44
  br label %while45

merge39:                                          ; preds = %while37
  br label %block_end35

block_end42:                                      ; preds = %block_end43
  br label %while37

block_end43:                                      ; preds = %merge47
  %le93 = load i32, i32* %y
  %Asn94 = sub i32 %le93, 1
  store i32 %Asn94, i32* %y
  %7 = load i32, i32* %y
  br label %block_end42

while45:                                          ; preds = %block_end51, %while_body38
  %x48 = load i32, i32* %x44
  %board_width49 = load i32, i32* @"variable::board_width"
  %tmp50 = icmp slt i32 %x48, %board_width49
  br i1 %tmp50, label %while_body46, label %merge47

while_body46:                                     ; preds = %while45
  %x53 = load i32, i32* %x44
  %y54 = load i32, i32* %y
  %tmp55 = sub i32 %y54, 1
  %pieces56 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces
  %arr57 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces56, [24 x [10 x %objref]]* %arr57
  %8 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr57, i32 0, i32 %tmp55
  %subscript58 = load [10 x %objref], [10 x %objref]* %8
  %arr59 = alloca [10 x %objref]
  store [10 x %objref] %subscript58, [10 x %objref]* %arr59
  %9 = getelementptr [10 x %objref], [10 x %objref]* %arr59, i32 0, i32 %x53
  %subscript60 = load %objref, %objref* %9
  %y61 = load i32, i32* %y
  %subscript62 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces, i32 0, i32 %y61
  %x63 = load i32, i32* %x44
  %subscript64 = getelementptr [10 x %objref], [10 x %objref]* %subscript62, i32 0, i32 %x63
  store %objref %subscript60, %objref* %subscript64
  %10 = load %objref, %objref* %subscript64
  %x65 = load i32, i32* %x44
  %y66 = load i32, i32* %y
  %pieces67 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces
  %arr68 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces67, [24 x [10 x %objref]]* %arr68
  %11 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr68, i32 0, i32 %y66
  %subscript69 = load [10 x %objref], [10 x %objref]* %11
  %arr70 = alloca [10 x %objref]
  store [10 x %objref] %subscript69, [10 x %objref]* %arr70
  %12 = getelementptr [10 x %objref], [10 x %objref]* %arr70, i32 0, i32 %x65
  %subscript71 = load %objref, %objref* %12
  %tmp_lid72 = extractvalue %objref %subscript71, 0
  %tmp73 = icmp ne i64 %tmp_lid72, 0
  br i1 %tmp73, label %then75, label %else89

merge47:                                          ; preds = %while45
  br label %block_end43

block_end51:                                      ; preds = %block_end52
  br label %while45

block_end52:                                      ; preds = %merge74
  %le91 = load i32, i32* %x44
  %Asn92 = add i32 %le91, 1
  store i32 %Asn92, i32* %x44
  %13 = load i32, i32* %x44
  br label %block_end51

merge74:                                          ; preds = %block_end90, %then75
  br label %block_end52

then75:                                           ; preds = %while_body46
  %x76 = load i32, i32* %x44
  %y77 = load i32, i32* %y
  %pieces78 = load [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces
  %arr79 = alloca [24 x [10 x %objref]]
  store [24 x [10 x %objref]] %pieces78, [24 x [10 x %objref]]* %arr79
  %14 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %arr79, i32 0, i32 %y77
  %subscript80 = load [10 x %objref], [10 x %objref]* %14
  %arr81 = alloca [10 x %objref]
  store [10 x %objref] %subscript80, [10 x %objref]* %arr81
  %15 = getelementptr [10 x %objref], [10 x %objref]* %arr81, i32 0, i32 %x76
  %subscript82 = load %objref, %objref* %15
  %objptr_gen83 = extractvalue %objref %subscript82, 1
  %objptr84 = bitcast %gameobj* %objptr_gen83 to %Block*
  %piece = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 2
  %s = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 3
  %type_rect = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 4
  %type_y = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 5
  %type_x = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 6
  %y85 = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 7
  %x86 = getelementptr inbounds %Block, %Block* %objptr84, i32 0, i32 8
  %le87 = load i32, i32* %y85
  %Asn88 = add i32 %le87, 1
  store i32 %Asn88, i32* %y85
  %16 = load i32, i32* %y85
  br label %merge74

else89:                                           ; preds = %while_body46
  br label %block_end90

block_end90:                                      ; preds = %else89
  br label %merge74

block_end95:                                      ; preds = %merge99
  %lines_count = load %objref, %objref* @"variable::lines_count"
  %objptr_gen109 = extractvalue %objref %lines_count, 1
  %objptr110 = bitcast %gameobj* %objptr_gen109 to %Draw*
  %digits = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 5
  %y111 = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 6
  %x112 = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr110, i32 0, i32 8
  %le113 = load i32, i32* %n
  %Asn114 = add i32 %le113, 1
  store i32 %Asn114, i32* %n
  %17 = load i32, i32* %n
  %lines_count115 = load %objref, %objref* @"variable::lines_count"
  %objptr_gen116 = extractvalue %objref %lines_count115, 1
  %objptr117 = bitcast %gameobj* %objptr_gen116 to %Draw*
  %digits118 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 2
  %n119 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 3
  %height120 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 4
  %width121 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 5
  %y122 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 6
  %x123 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 7
  %spr124 = getelementptr inbounds %Draw, %Draw* %objptr117, i32 0, i32 8
  %n125 = load i32, i32* %n119
  %tmp126 = sdiv i32 %n125, 5
  %level_count = load %objref, %objref* @"variable::level_count"
  %objptr_gen127 = extractvalue %objref %level_count, 1
  %objptr128 = bitcast %gameobj* %objptr_gen127 to %Draw*
  %digits129 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 2
  %n130 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 3
  %height131 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 4
  %width132 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 5
  %y133 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 6
  %x134 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 7
  %spr135 = getelementptr inbounds %Draw, %Draw* %objptr128, i32 0, i32 8
  %n136 = load i32, i32* %n130
  %tmp137 = icmp sgt i32 %tmp126, %n136
  br i1 %tmp137, label %then139, label %else163

while97:                                          ; preds = %block_end103, %block_end35
  %x100 = load i32, i32* %x96
  %board_width101 = load i32, i32* @"variable::board_width"
  %tmp102 = icmp slt i32 %x100, %board_width101
  br i1 %tmp102, label %while_body98, label %merge99

while_body98:                                     ; preds = %while97
  %subscript104 = getelementptr [24 x [10 x %objref]], [24 x [10 x %objref]]* %pieces, i32 0, i32 0
  %x105 = load i32, i32* %x96
  %subscript106 = getelementptr [10 x %objref], [10 x %objref]* %subscript104, i32 0, i32 %x105
  store %objref zeroinitializer, %objref* %subscript106
  %18 = load %objref, %objref* %subscript106
  %le107 = load i32, i32* %x96
  %Asn108 = add i32 %le107, 1
  store i32 %Asn108, i32* %x96
  %19 = load i32, i32* %x96
  br label %block_end103

merge99:                                          ; preds = %while97
  br label %block_end95

block_end103:                                     ; preds = %while_body98
  br label %while97

merge138:                                         ; preds = %block_end164, %block_end140
  %level_count165 = load %objref, %objref* @"variable::level_count"
  %objptr_gen166 = extractvalue %objref %level_count165, 1
  %objptr167 = bitcast %gameobj* %objptr_gen166 to %Draw*
  %digits168 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 2
  %n169 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 3
  %height170 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 4
  %width171 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 5
  %y172 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 6
  %x173 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 7
  %spr174 = getelementptr inbounds %Draw, %Draw* %objptr167, i32 0, i32 8
  %n175 = load i32, i32* %n169
  %tmp176 = icmp sgt i32 %n175, 99
  br i1 %tmp176, label %then178, label %else189

then139:                                          ; preds = %block_end95
  %lines_count141 = load %objref, %objref* @"variable::lines_count"
  %objptr_gen142 = extractvalue %objref %lines_count141, 1
  %objptr143 = bitcast %gameobj* %objptr_gen142 to %Draw*
  %digits144 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 2
  %n145 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 3
  %height146 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 4
  %width147 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 5
  %y148 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 6
  %x149 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 7
  %spr150 = getelementptr inbounds %Draw, %Draw* %objptr143, i32 0, i32 8
  %n151 = load i32, i32* %n145
  %tmp152 = sdiv i32 %n151, 5
  %level_count153 = load %objref, %objref* @"variable::level_count"
  %objptr_gen154 = extractvalue %objref %level_count153, 1
  %objptr155 = bitcast %gameobj* %objptr_gen154 to %Draw*
  %digits156 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 2
  %n157 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 3
  %height158 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 4
  %width159 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 5
  %y160 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 6
  %x161 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 7
  %spr162 = getelementptr inbounds %Draw, %Draw* %objptr155, i32 0, i32 8
  store i32 %tmp152, i32* %n157
  %20 = load i32, i32* %n157
  %level = load %sfSound*, %sfSound** @"variable::snds::level"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %level)
  br label %block_end140

block_end140:                                     ; preds = %then139
  br label %merge138

else163:                                          ; preds = %block_end95
  br label %block_end164

block_end164:                                     ; preds = %else163
  br label %merge138

merge177:                                         ; preds = %block_end190, %then178
  ret i1 true

then178:                                          ; preds = %merge138
  %level_count179 = load %objref, %objref* @"variable::level_count"
  %objptr_gen180 = extractvalue %objref %level_count179, 1
  %objptr181 = bitcast %gameobj* %objptr_gen180 to %Draw*
  %digits182 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 2
  %n183 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 3
  %height184 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 4
  %width185 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 5
  %y186 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 6
  %x187 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 7
  %spr188 = getelementptr inbounds %Draw, %Draw* %objptr181, i32 0, i32 8
  store i32 99, i32* %n183
  %21 = load i32, i32* %n183
  br label %merge177

else189:                                          ; preds = %merge138
  br label %block_end190

block_end190:                                     ; preds = %else189
  br label %merge177

postret191:                                       ; No predecessors!
  br label %block_end
}

define void @"object::Board.function.checkRows"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Board*
  %pieces = getelementptr inbounds %Board, %Board* %objptr, i32 0, i32 2
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
  %digits = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 5
  %y24 = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 6
  %x = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr23, i32 0, i32 8
  %le25 = load i32, i32* %n
  %lines26 = load i32, i32* %lines
  %points = load [5 x i32], [5 x i32]* @"variable::points"
  %arr = alloca [5 x i32]
  store [5 x i32] %points, [5 x i32]* %arr
  %2 = getelementptr [5 x i32], [5 x i32]* %arr, i32 0, i32 %lines26
  %subscript = load i32, i32* %2
  %level_count = load %objref, %objref* @"variable::level_count"
  %objptr_gen27 = extractvalue %objref %level_count, 1
  %objptr28 = bitcast %gameobj* %objptr_gen27 to %Draw*
  %digits29 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 2
  %n30 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 3
  %height31 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 4
  %width32 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 5
  %y33 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 6
  %x34 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 7
  %spr35 = getelementptr inbounds %Draw, %Draw* %objptr28, i32 0, i32 8
  %n36 = load i32, i32* %n30
  %tmp37 = add i32 %n36, 1
  %tmp38 = mul i32 %subscript, %tmp37
  %Asn39 = add i32 %le25, %tmp38
  store i32 %Asn39, i32* %n
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
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen3 = extractvalue %objref %score_count, 1
  %objptr4 = bitcast %gameobj* %objptr_gen3 to %Draw*
  %digits = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 5
  %y = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 6
  %x = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr4, i32 0, i32 8
  %n5 = load i32, i32* %n
  %top_count = load %objref, %objref* @"variable::top_count"
  %objptr_gen6 = extractvalue %objref %top_count, 1
  %objptr7 = bitcast %gameobj* %objptr_gen6 to %Draw*
  %digits8 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 2
  %n9 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 3
  %height10 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 4
  %width11 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 5
  %y12 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 6
  %x13 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 7
  %spr14 = getelementptr inbounds %Draw, %Draw* %objptr7, i32 0, i32 8
  store i32 %n5, i32* %n9
  %0 = load i32, i32* %n9
  %this15 = load %objref, %objref* %this1
  call void @_empty_fn(%objref %this15)
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
  %malloccall8 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw = bitcast i8* %malloccall8 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw
  %Draw_gen = bitcast %Draw* %Draw to %gameobj*
  %Draw_objnode = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 1
  %marker9 = getelementptr inbounds %node, %node* %Draw_objnode, i32 0, i32 2
  store i1 true, i1* %marker9
  call void @list_add(%node* %Draw_objnode, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.head")
  %Draw_parent = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 0
  %object_objnode10 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 1
  %marker11 = getelementptr inbounds %node, %node* %object_objnode10, i32 0, i32 2
  store i1 true, i1* %marker11
  call void @list_add(%node* %object_objnode10, %node* @node.gameobj.head)
  %object_parent12 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 0
  %old_id13 = load i64, i64* @last_objid
  %new_id14 = add i64 %old_id13, 1
  store i64 %new_id14, i64* @last_objid
  %28 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %28
  %29 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 2
  store i64 %new_id14, i64* %29
  %30 = insertvalue %objref undef, i64 %new_id14, 0
  %31 = insertvalue %objref %30, %gameobj* %Draw_gen, 1
  %i15 = load i32, i32* %i
  %tmp16 = mul i32 16, %i15
  %tmp17 = add i32 88, %tmp16
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/tetris/draw_numbers.mg::Draw.event.create"(%objref %31, i32 48, i32 %tmp17, i32 3)
  %i18 = load i32, i32* %i
  %subscript = getelementptr [7 x %objref], [7 x %objref]* @"variable::piece_counts", i32 0, i32 %i18
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
  %n = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 2
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
  %n = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 2
  %timer = getelementptr inbounds %game_over, %game_over* %objptr2, i32 0, i32 3
  %le = load i32, i32* %timer
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %timer
  %0 = load i32, i32* %timer
  %timer3 = load i32, i32* %timer
  %game_over_fade = load i32, i32* @"variable::game_over_fade"
  %tmp = icmp eq i32 %timer3, %game_over_fade
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge17
  ret void

merge:                                            ; preds = %block_end5, %then
  %timer6 = load i32, i32* %timer
  %game_over_fade7 = load i32, i32* @"variable::game_over_fade"
  %game_over_delay = load i32, i32* @"variable::game_over_delay"
  %tmp8 = add i32 %game_over_fade7, %game_over_delay
  %tmp9 = icmp sge i32 %timer6, %tmp8
  %score_count = load %objref, %objref* @"variable::score_count"
  %objptr_gen10 = extractvalue %objref %score_count, 1
  %objptr11 = bitcast %gameobj* %objptr_gen10 to %Draw*
  %digits = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 2
  %n12 = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 3
  %height = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 4
  %width = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 5
  %y = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 6
  %x = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 7
  %spr = getelementptr inbounds %Draw, %Draw* %objptr11, i32 0, i32 8
  %n13 = load i32, i32* %n12
  %n14 = load i32, i32* %n
  %tmp15 = icmp slt i32 %n13, %n14
  %tmp16 = and i1 %tmp9, %tmp15
  br i1 %tmp16, label %then18, label %else66

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
  %marker4 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker4
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
  br label %block_end5

block_end5:                                       ; preds = %else
  br label %merge

merge17:                                          ; preds = %block_end67, %block_end19
  %this68 = load %objref, %objref* %this1
  call void @_empty_fn(%objref %this68)
  br label %block_end

then18:                                           ; preds = %merge
  %add = alloca i32
  %n20 = load i32, i32* %n
  %game_over_delay21 = load i32, i32* @"variable::game_over_delay"
  %tmp22 = sdiv i32 %n20, %game_over_delay21
  %tmp23 = sdiv i32 %tmp22, 2
  %tmp24 = add i32 %tmp23, 1
  store i32 %tmp24, i32* %add
  %score_count25 = load %objref, %objref* @"variable::score_count"
  %objptr_gen26 = extractvalue %objref %score_count25, 1
  %objptr27 = bitcast %gameobj* %objptr_gen26 to %Draw*
  %digits28 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 2
  %n29 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 3
  %height30 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 4
  %width31 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 5
  %y32 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 6
  %x33 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 7
  %spr34 = getelementptr inbounds %Draw, %Draw* %objptr27, i32 0, i32 8
  %le35 = load i32, i32* %n29
  %add36 = load i32, i32* %add
  %Asn37 = add i32 %le35, %add36
  store i32 %Asn37, i32* %n29
  %6 = load i32, i32* %n29
  %score_count38 = load %objref, %objref* @"variable::score_count"
  %objptr_gen39 = extractvalue %objref %score_count38, 1
  %objptr40 = bitcast %gameobj* %objptr_gen39 to %Draw*
  %digits41 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 2
  %n42 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 3
  %height43 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 4
  %width44 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 5
  %y45 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 6
  %x46 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 7
  %spr47 = getelementptr inbounds %Draw, %Draw* %objptr40, i32 0, i32 8
  %n48 = load i32, i32* %n42
  %n49 = load i32, i32* %n
  %tmp50 = icmp sgt i32 %n48, %n49
  br i1 %tmp50, label %then52, label %else64

block_end19:                                      ; preds = %merge51
  br label %merge17

merge51:                                          ; preds = %block_end65, %then52
  br label %block_end19

then52:                                           ; preds = %then18
  %n53 = load i32, i32* %n
  %score_count54 = load %objref, %objref* @"variable::score_count"
  %objptr_gen55 = extractvalue %objref %score_count54, 1
  %objptr56 = bitcast %gameobj* %objptr_gen55 to %Draw*
  %digits57 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 2
  %n58 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 3
  %height59 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 4
  %width60 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 5
  %y61 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 6
  %x62 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 7
  %spr63 = getelementptr inbounds %Draw, %Draw* %objptr56, i32 0, i32 8
  store i32 %n53, i32* %n58
  %7 = load i32, i32* %n58
  br label %merge51

else64:                                           ; preds = %then18
  br label %block_end65

block_end65:                                      ; preds = %else64
  br label %merge51

else66:                                           ; preds = %merge
  br label %block_end67

block_end67:                                      ; preds = %else66
  br label %merge17
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
  %n = getelementptr inbounds %game_over, %game_over* %objptr3, i32 0, i32 2
  %timer = getelementptr inbounds %game_over, %game_over* %objptr3, i32 0, i32 3
  %this4 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::room.event.create"(%objref %this4)
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
