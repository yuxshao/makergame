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
%Draw = type { %gameobj, %node, i32, i32, double, double, [10 x %sfSprite*] }
%Egg = type { %obj, %node, i32 }
%gameover = type { %room, %node, %sfSprite* }
%SineEgg = type { %Egg, %node, i32 }
%Player = type { %obj, %node }
%Spawner = type { %gameobj, %node, i32 }
%main = type { %room, %node }

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
@"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.head" = global %node { %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.head", %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.head", i1 false }
@Draw.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.event.draw", void (%objref)* @"delete_%Draw = type { %gameobj, %node, i32, i32, double, double, [10 x %sfSprite*] }" }
@"variable::numbers" = global %objref zeroinitializer
@"variable::boinkSound" = global %sfSound* null
@"variable::score" = global i32 0
@"variable::times" = global i32 0
@"node.object::Egg.head" = global %node { %node* @"node.object::Egg.head", %node* @"node.object::Egg.head", i1 false }
@Egg.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::Egg.event.step", void (%objref)* @_empty_fn, void (%objref)* @"object:file-../../lib/game.mg::obj.event.draw", void (%objref)* @"delete_%Egg = type { %obj, %node, i32 }" }
@"node.object::SineEgg.head" = global %node { %node* @"node.object::SineEgg.head", %node* @"node.object::SineEgg.head", i1 false }
@SineEgg.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::SineEgg.event.step", void (%objref)* @_empty_fn, void (%objref)* @"object:file-../../lib/game.mg::obj.event.draw", void (%objref)* @"delete_%SineEgg = type { %Egg, %node, i32 }" }
@"node.object::Player.head" = global %node { %node* @"node.object::Player.head", %node* @"node.object::Player.head", i1 false }
@Player.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::Player.event.step", void (%objref)* @_empty_fn, void (%objref)* @"object:file-../../lib/game.mg::obj.event.draw", void (%objref)* @"delete_%Player = type { %obj, %node }" }
@"node.object::Spawner.head" = global %node { %node* @"node.object::Spawner.head", %node* @"node.object::Spawner.head", i1 false }
@Spawner.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @"object::Spawner.event.step", void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"delete_%Spawner = type { %gameobj, %node, i32 }" }
@"node.object::main.head" = global %node { %node* @"node.object::main.head", %node* @"node.object::main.head", i1 false }
@main.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"delete_%main = type { %room, %node }" }
@"node.object::gameover.head" = global %node { %node* @"node.object::gameover.head", %node* @"node.object::gameover.head", i1 false }
@gameover.vtable = global { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* } { void (%objref)* @_empty_fn, void (%objref)* @_empty_fn, void (%objref)* @"object::gameover.event.draw", void (%objref)* @"delete_%gameover = type { %room, %node, %sfSprite* }" }
@0 = private unnamed_addr constant [5 x i8] c"loop\00"
@1 = private unnamed_addr constant [9 x i8] c"loop end\00"
@2 = private unnamed_addr constant [5 x i8] c"loop\00"
@3 = private unnamed_addr constant [9 x i8] c"loop end\00"
@literal = private unnamed_addr constant [8 x i8] c"egg.png\00"
@literal.1 = private unnamed_addr constant [15 x i8] c"flying-egg.png\00"
@4 = private unnamed_addr constant [5 x i8] c"loop\00"
@5 = private unnamed_addr constant [9 x i8] c"loop end\00"
@literal.2 = private unnamed_addr constant [11 x i8] c"player.png\00"
@literal.3 = private unnamed_addr constant [9 x i8] c"egg game\00"
@literal.4 = private unnamed_addr constant [10 x i8] c"boink.ogx\00"
@literal.5 = private unnamed_addr constant [13 x i8] c"gameover.png\00"
@literal.6 = private unnamed_addr constant [14 x i8] c"numbers/0.png\00"
@literal.7 = private unnamed_addr constant [14 x i8] c"numbers/1.png\00"
@literal.8 = private unnamed_addr constant [14 x i8] c"numbers/2.png\00"
@literal.9 = private unnamed_addr constant [14 x i8] c"numbers/3.png\00"
@literal.10 = private unnamed_addr constant [14 x i8] c"numbers/4.png\00"
@literal.11 = private unnamed_addr constant [14 x i8] c"numbers/5.png\00"
@literal.12 = private unnamed_addr constant [14 x i8] c"numbers/6.png\00"
@literal.13 = private unnamed_addr constant [14 x i8] c"numbers/7.png\00"
@literal.14 = private unnamed_addr constant [14 x i8] c"numbers/8.png\00"
@literal.15 = private unnamed_addr constant [14 x i8] c"numbers/9.png\00"
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

define void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Draw*
  %width = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %y = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 4
  %x = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 5
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %n2 = alloca i32
  %this3 = load %objref, %objref* %this1
  %objptr_gen4 = extractvalue %objref %this3, 1
  %objptr5 = bitcast %gameobj* %objptr_gen4 to %Draw*
  %width6 = getelementptr inbounds %Draw, %Draw* %objptr5, i32 0, i32 2
  %n7 = getelementptr inbounds %Draw, %Draw* %objptr5, i32 0, i32 3
  %y8 = getelementptr inbounds %Draw, %Draw* %objptr5, i32 0, i32 4
  %x9 = getelementptr inbounds %Draw, %Draw* %objptr5, i32 0, i32 5
  %spr10 = getelementptr inbounds %Draw, %Draw* %objptr5, i32 0, i32 6
  %n11 = load i32, i32* %n7
  store i32 %n11, i32* %n2
  %n12 = load i32, i32* %n2
  %tmp = icmp slt i32 %n12, 0
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end13, %then
  %n14 = load i32, i32* %n2
  %x15 = load double, double* %x
  %this16 = load %objref, %objref* %this1
  %draw_indiv_result = call i32 @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.function.draw_indiv"(%objref %this16, i32 %n14, double %x15)
  br label %block_end

then:                                             ; preds = %entry
  store i32 0, i32* %n2
  %0 = load i32, i32* %n2
  br label %merge

else:                                             ; preds = %entry
  br label %block_end13

block_end13:                                      ; preds = %else
  br label %merge
}

define void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.event.create"(%objref %this, i32 %number, double %x, double %y) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %number2 = alloca i32
  store i32 %number, i32* %number2
  %x3 = alloca double
  store double %x, double* %x3
  %y4 = alloca double
  store double %y, double* %y4
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Draw*
  %width = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %y5 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 4
  %x6 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 5
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %x7 = load double, double* %x3
  %this8 = load %objref, %objref* %this1
  %objptr_gen9 = extractvalue %objref %this8, 1
  %objptr10 = bitcast %gameobj* %objptr_gen9 to %Draw*
  %width11 = getelementptr inbounds %Draw, %Draw* %objptr10, i32 0, i32 2
  %n12 = getelementptr inbounds %Draw, %Draw* %objptr10, i32 0, i32 3
  %y13 = getelementptr inbounds %Draw, %Draw* %objptr10, i32 0, i32 4
  %x14 = getelementptr inbounds %Draw, %Draw* %objptr10, i32 0, i32 5
  %spr15 = getelementptr inbounds %Draw, %Draw* %objptr10, i32 0, i32 6
  store double %x7, double* %x14
  %0 = load double, double* %x14
  %y16 = load double, double* %y4
  %this17 = load %objref, %objref* %this1
  %objptr_gen18 = extractvalue %objref %this17, 1
  %objptr19 = bitcast %gameobj* %objptr_gen18 to %Draw*
  %width20 = getelementptr inbounds %Draw, %Draw* %objptr19, i32 0, i32 2
  %n21 = getelementptr inbounds %Draw, %Draw* %objptr19, i32 0, i32 3
  %y22 = getelementptr inbounds %Draw, %Draw* %objptr19, i32 0, i32 4
  %x23 = getelementptr inbounds %Draw, %Draw* %objptr19, i32 0, i32 5
  %spr24 = getelementptr inbounds %Draw, %Draw* %objptr19, i32 0, i32 6
  store double %y16, double* %y22
  %1 = load double, double* %y22
  %number25 = load i32, i32* %number2
  store i32 %number25, i32* %n
  %2 = load i32, i32* %n
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.6, i32 0, i32 0))
  %load_result26 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.7, i32 0, i32 0))
  %load_result27 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.8, i32 0, i32 0))
  %load_result28 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.9, i32 0, i32 0))
  %load_result29 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.10, i32 0, i32 0))
  %load_result30 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.11, i32 0, i32 0))
  %load_result31 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.12, i32 0, i32 0))
  %load_result32 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.13, i32 0, i32 0))
  %load_result33 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.14, i32 0, i32 0))
  %load_result34 = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @literal.15, i32 0, i32 0))
  %3 = insertvalue [10 x %sfSprite*] undef, %sfSprite* %load_result, 0
  %4 = insertvalue [10 x %sfSprite*] %3, %sfSprite* %load_result26, 1
  %5 = insertvalue [10 x %sfSprite*] %4, %sfSprite* %load_result27, 2
  %6 = insertvalue [10 x %sfSprite*] %5, %sfSprite* %load_result28, 3
  %7 = insertvalue [10 x %sfSprite*] %6, %sfSprite* %load_result29, 4
  %8 = insertvalue [10 x %sfSprite*] %7, %sfSprite* %load_result30, 5
  %9 = insertvalue [10 x %sfSprite*] %8, %sfSprite* %load_result31, 6
  %10 = insertvalue [10 x %sfSprite*] %9, %sfSprite* %load_result32, 7
  %11 = insertvalue [10 x %sfSprite*] %10, %sfSprite* %load_result33, 8
  %12 = insertvalue [10 x %sfSprite*] %11, %sfSprite* %load_result34, 9
  store [10 x %sfSprite*] %12, [10 x %sfSprite*]* %spr
  %13 = load [10 x %sfSprite*], [10 x %sfSprite*]* %spr
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%Draw = type { %gameobj, %node, i32, i32, double, double, [10 x %sfSprite*] }"(%objref) {
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

define i32 @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.function.draw_indiv"(%objref %this, i32 %n, double %X) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %n2 = alloca i32
  store i32 %n, i32* %n2
  %X3 = alloca double
  store double %X, double* %X3
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Draw*
  %width = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 2
  %n4 = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 3
  %y = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 4
  %x = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 5
  %spr = getelementptr inbounds %Draw, %Draw* %objptr, i32 0, i32 6
  %n5 = load i32, i32* %n2
  %tmp = icmp sgt i32 %n5, 9
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %postret
  ret i32 0

merge:                                            ; preds = %block_end10, %then
  %n11 = load i32, i32* %n2
  %tmp12 = srem i32 %n11, 10
  %spr13 = load [10 x %sfSprite*], [10 x %sfSprite*]* %spr
  %arr = alloca [10 x %sfSprite*]
  store [10 x %sfSprite*] %spr13, [10 x %sfSprite*]* %arr
  %0 = getelementptr [10 x %sfSprite*], [10 x %sfSprite*]* %arr, i32 0, i32 %tmp12
  %subscript = load %sfSprite*, %sfSprite** %0
  %X14 = load double, double* %X3
  %y15 = load double, double* %y
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %subscript, double %X14, double %y15)
  %X16 = load double, double* %X3
  %n17 = load i32, i32* %n2
  %tmp18 = srem i32 %n17, 10
  %spr19 = load [10 x %sfSprite*], [10 x %sfSprite*]* %spr
  %arr20 = alloca [10 x %sfSprite*]
  store [10 x %sfSprite*] %spr19, [10 x %sfSprite*]* %arr20
  %1 = getelementptr [10 x %sfSprite*], [10 x %sfSprite*]* %arr20, i32 0, i32 %tmp18
  %subscript21 = load %sfSprite*, %sfSprite** %1
  %width_result = call i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %subscript21)
  %2 = sitofp i32 %width_result to double
  %tmp22 = fadd double %X16, %2
  %3 = fptosi double %tmp22 to i32
  ret i32 %3

then:                                             ; preds = %entry
  %n6 = load i32, i32* %n2
  %tmp7 = sdiv i32 %n6, 10
  %X8 = load double, double* %X3
  %this9 = load %objref, %objref* %this1
  %draw_indiv_result = call i32 @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.function.draw_indiv"(%objref %this9, i32 %tmp7, double %X8)
  %4 = sitofp i32 %draw_indiv_result to double
  store double %4, double* %X3
  %5 = load double, double* %X3
  br label %merge

else:                                             ; preds = %entry
  br label %block_end10

block_end10:                                      ; preds = %else
  br label %merge

postret:                                          ; No predecessors!
  br label %block_end
}

define void @"object::Egg.event.step"(%objref %this) {
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
  %objptr2 = bitcast %gameobj* %objptr_gen to %Egg*
  %points = getelementptr inbounds %Egg, %Egg* %objptr2, i32 0, i32 2
  %y3 = load double, double* %y
  %tmp = fcmp ogt double %y3, 6.000000e+02
  br i1 %tmp, label %then, label %else

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end6, %then
  br label %block_end

then:                                             ; preds = %entry
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%gameover* getelementptr (%gameover, %gameover* null, i32 1) to i32))
  %gameover = bitcast i8* %malloccall to %gameover*
  store %gameover zeroinitializer, %gameover* %gameover
  %gameover_gen = bitcast %gameover* %gameover to %gameobj*
  %gameover_objnode = getelementptr inbounds %gameover, %gameover* %gameover, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %gameover_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %gameover_objnode, %node* @"node.object::gameover.head")
  %gameover_parent = getelementptr inbounds %gameover, %gameover* %gameover, i32 0, i32 0
  %room_objnode = getelementptr inbounds %room, %room* %gameover_parent, i32 0, i32 1
  %marker4 = getelementptr inbounds %node, %node* %room_objnode, i32 0, i32 2
  store i1 true, i1* %marker4
  call void @list_add(%node* %room_objnode, %node* @"node.object:file-../../lib/game.mg::room.head")
  %room_parent = getelementptr inbounds %room, %room* %gameover_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 1
  %marker5 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker5
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %room_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %0 = getelementptr inbounds %gameobj, %gameobj* %gameover_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @gameover.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %0
  %1 = getelementptr inbounds %gameobj, %gameobj* %gameover_gen, i32 0, i32 2
  store i64 %new_id, i64* %1
  %2 = insertvalue %objref undef, i64 %new_id, 0
  %3 = insertvalue %objref %2, %gameobj* %gameover_gen, 1
  call void @"object::gameover.event.create"(%objref %3)
  br label %merge

else:                                             ; preds = %entry
  br label %block_end6

block_end6:                                       ; preds = %else
  br label %merge
}

define void @"object::Egg.event.create"(%objref %this, double %x, double %y) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca double
  store double %x, double* %x2
  %y3 = alloca double
  store double %y, double* %y3
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
  %y4 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x5 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %objptr6 = bitcast %gameobj* %objptr_gen to %Egg*
  %points = getelementptr inbounds %Egg, %Egg* %objptr6, i32 0, i32 2
  %x7 = load double, double* %x2
  %y8 = load double, double* %y3
  %this9 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.event.create"(%objref %this9, double %x7, double %y8, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @literal, i32 0, i32 0))
  %frandom_result = call double @"function:file-../../lib/math.mg::frandom"()
  %times = load i32, i32* @"variable::times"
  %0 = sitofp i32 %times to double
  %tmp = fmul double %0, 2.000000e-02
  %tmp10 = fadd double 1.400000e+00, %tmp
  %tmp11 = fmul double %frandom_result, %tmp10
  %tmp12 = fadd double 3.000000e+00, %tmp11
  store double %tmp12, double* %vspeed
  %1 = load double, double* %vspeed
  %vspeed13 = load double, double* %vspeed
  %tmp14 = fmul double %vspeed13, 1.000000e+01
  %2 = fptosi double %tmp14 to i32
  store i32 %2, i32* %points
  %3 = load i32, i32* %points
  %boinkSound = load %sfSound*, %sfSound** @"variable::boinkSound"
  call void @"function:file-../../lib/sound.mg::play"(%sfSound* %boinkSound)
  %this15 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.center_hitbox_prop"(%objref %this15, double 9.000000e-01, double 9.000000e-01)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%Egg = type { %obj, %node, i32 }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Egg*
  %objnode = getelementptr inbounds %Egg, %Egg* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Egg, %Egg* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %obj, %obj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %obj, %obj* %2, i32 0, i32 0
  %objnode2 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 1
  call void @list_rem(%node* %objnode2)
  %4 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 0
  ret void
}

define void @"object::SineEgg.event.step"(%objref %this) {
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
  %objptr2 = bitcast %gameobj* %objptr_gen to %Egg*
  %points = getelementptr inbounds %Egg, %Egg* %objptr2, i32 0, i32 2
  %objptr3 = bitcast %gameobj* %objptr_gen to %SineEgg*
  %timer = getelementptr inbounds %SineEgg, %SineEgg* %objptr3, i32 0, i32 2
  %this4 = load %objref, %objref* %this1
  call void @"object::Egg.event.step"(%objref %this4)
  %le = load i32, i32* %timer
  %Asn = add i32 %le, 1
  store i32 %Asn, i32* %timer
  %0 = load i32, i32* %timer
  %timer5 = load i32, i32* %timer
  %1 = sitofp i32 %timer5 to double
  %tmp = fmul double %1, 1.000000e-01
  %sin_result = call double @sin(double %tmp)
  %tmp6 = fmul double 5.000000e+00, %sin_result
  store double %tmp6, double* %hspeed
  %2 = load double, double* %hspeed
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::SineEgg.event.create"(%objref %this, double %x, double %y) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %x2 = alloca double
  store double %x, double* %x2
  %y3 = alloca double
  store double %y, double* %y3
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
  %y4 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 10
  %x5 = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 11
  %spr = getelementptr inbounds %obj, %obj* %objptr, i32 0, i32 12
  %objptr6 = bitcast %gameobj* %objptr_gen to %Egg*
  %points = getelementptr inbounds %Egg, %Egg* %objptr6, i32 0, i32 2
  %objptr7 = bitcast %gameobj* %objptr_gen to %SineEgg*
  %timer = getelementptr inbounds %SineEgg, %SineEgg* %objptr7, i32 0, i32 2
  %x8 = load double, double* %x2
  %y9 = load double, double* %y3
  %this10 = load %objref, %objref* %this1
  call void @"object::Egg.event.create"(%objref %this10, double %x8, double %y9)
  %le = load i32, i32* %points
  %Asn = mul i32 %le, 1
  store i32 %Asn, i32* %points
  %0 = load i32, i32* %points
  store i32 0, i32* %timer
  %1 = load i32, i32* %timer
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @literal.1, i32 0, i32 0))
  store %sfSprite* %load_result, %sfSprite** %spr
  %2 = load %sfSprite*, %sfSprite** %spr
  %spr11 = load %sfSprite*, %sfSprite** %spr
  %width_result = call i32 @"function:file-../../lib/sprite.mg::width"(%sfSprite* %spr11)
  %tmp = sub i32 0, %width_result
  %tmp12 = sdiv i32 %tmp, 2
  %3 = sitofp i32 %tmp12 to double
  store double %3, double* %hitbox_offx
  %4 = load double, double* %hitbox_offx
  %spr13 = load %sfSprite*, %sfSprite** %spr
  %height_result = call i32 @"function:file-../../lib/sprite.mg::height"(%sfSprite* %spr13)
  %tmp14 = sub i32 0, %height_result
  %tmp15 = sdiv i32 %tmp14, 2
  %5 = sitofp i32 %tmp15 to double
  store double %5, double* %hitbox_offy
  %6 = load double, double* %hitbox_offy
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%SineEgg = type { %Egg, %node, i32 }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %SineEgg*
  %objnode = getelementptr inbounds %SineEgg, %SineEgg* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %SineEgg, %SineEgg* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %Egg, %Egg* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %Egg, %Egg* %2, i32 0, i32 0
  %objnode2 = getelementptr inbounds %obj, %obj* %3, i32 0, i32 1
  call void @list_rem(%node* %objnode2)
  %4 = getelementptr inbounds %obj, %obj* %3, i32 0, i32 0
  %objnode3 = getelementptr inbounds %gameobj, %gameobj* %4, i32 0, i32 1
  call void @list_rem(%node* %objnode3)
  %5 = getelementptr inbounds %gameobj, %gameobj* %4, i32 0, i32 0
  ret void
}

define void @"object::Player.event.step"(%objref %this) {
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
  %objptr2 = bitcast %gameobj* %objptr_gen to %Player*
  %Left = load i32, i32* @"variable:file-../../lib/key.mg::Left"
  %is_down_result = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Left)
  br i1 %is_down_result, label %then, label %else

block_end:                                        ; preds = %merge11
  ret void

merge:                                            ; preds = %block_end3, %then
  %Right = load i32, i32* @"variable:file-../../lib/key.mg::Right"
  %is_down_result4 = call i1 @"function:file-../../lib/key.mg::is_down"(i32 %Right)
  br i1 %is_down_result4, label %then6, label %else9

then:                                             ; preds = %entry
  %le = load double, double* %x
  %Asn = fsub double %le, 5.000000e+00
  store double %Asn, double* %x
  %0 = load double, double* %x
  br label %merge

else:                                             ; preds = %entry
  br label %block_end3

block_end3:                                       ; preds = %else
  br label %merge

merge5:                                           ; preds = %block_end10, %then6
  %tail = alloca %node
  %marker = getelementptr inbounds %node, %node* %tail, i32 0, i32 2
  store i1 false, i1* %marker
  %curr_ptr = alloca %node*
  %next_ptr = alloca %node*
  call void @list_add(%node* %tail, %node* @"node.object::Egg.head")
  store %node* @"node.object::Egg.head", %node** %curr_ptr
  %1 = load %node*, %node** getelementptr inbounds (%node, %node* @"node.object::Egg.head", i32 0, i32 1)
  store %node* %1, %node** %next_ptr
  br label %while

then6:                                            ; preds = %merge
  %le7 = load double, double* %x
  %Asn8 = fadd double %le7, 5.000000e+00
  store double %Asn8, double* %x
  %2 = load double, double* %x
  br label %merge5

else9:                                            ; preds = %merge
  br label %block_end10

block_end10:                                      ; preds = %else9
  br label %merge5

while:                                            ; preds = %merge14, %merge5
  %curr = load %node*, %node** %next_ptr
  %3 = getelementptr inbounds %node, %node* %curr, i32 0, i32 1
  %next = load %node*, %node** %3
  %4 = ptrtoint %node* %curr to i64
  %5 = ptrtoint %node* %next to i64
  %6 = ptrtoint %node* %tail to i64
  store %node* %curr, %node** %curr_ptr
  store %node* %next, %node** %next_ptr
  %cont = icmp ne %node* %curr, @"node.object::Egg.head"
  br i1 %cont, label %while_body, label %merge11

while_body:                                       ; preds = %while
  %markerptr = getelementptr inbounds %node, %node* %curr, i32 0, i32 2
  %marker12 = load i1, i1* %markerptr
  %cont13 = icmp eq i1 %marker12, true
  br i1 %cont13, label %then15, label %else55

merge11:                                          ; preds = %while
  call void @list_rem(%node* %tail)
  br label %block_end

merge14:                                          ; preds = %merge57, %merge16
  br label %while

then15:                                           ; preds = %while_body
  %intptr = ptrtoint %node* %curr to i64
  %intnew = sub i64 %intptr, ptrtoint (%node* getelementptr inbounds (%Egg, %Egg* null, i32 0, i32 1) to i64)
  %Egg = inttoptr i64 %intnew to %gameobj*
  %id_ptr = getelementptr inbounds %gameobj, %gameobj* %Egg, i32 0, i32 2
  %id = load i64, i64* %id_ptr
  %is_removed = icmp ne i64 %id, 0
  br i1 %is_removed, label %then17, label %else54

merge16:                                          ; preds = %else54, %block_end19
  br label %merge14

then17:                                           ; preds = %then15
  %7 = getelementptr inbounds %gameobj, %gameobj* %Egg, i32 0, i32 2
  %id18 = load i64, i64* %7
  %8 = insertvalue %objref undef, i64 %id18, 0
  %9 = insertvalue %objref %8, %gameobj* %Egg, 1
  %ref = alloca %objref
  store %objref %9, %objref* %ref
  %egg = load %objref, %objref* %ref
  %this20 = load %objref, %objref* %this1
  %colliding_result = call i1 @"function:file-../../lib/game.mg::colliding"(%objref %egg, %objref %this20)
  br i1 %colliding_result, label %then22, label %else52

block_end19:                                      ; preds = %merge21
  br label %merge16

merge21:                                          ; preds = %block_end53, %block_end23
  br label %block_end19

then22:                                           ; preds = %then17
  %le24 = load i32, i32* @"variable::score"
  %egg25 = load %objref, %objref* %ref
  %objptr_gen26 = extractvalue %objref %egg25, 1
  %objptr27 = bitcast %gameobj* %objptr_gen26 to %obj*
  %hitbox_h28 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 2
  %hitbox_w29 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 3
  %hitbox_offy30 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 4
  %hitbox_offx31 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 5
  %origin_y32 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 6
  %origin_x33 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 7
  %vspeed34 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 8
  %hspeed35 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 9
  %y36 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 10
  %x37 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 11
  %spr38 = getelementptr inbounds %obj, %obj* %objptr27, i32 0, i32 12
  %objptr39 = bitcast %gameobj* %objptr_gen26 to %Egg*
  %points = getelementptr inbounds %Egg, %Egg* %objptr39, i32 0, i32 2
  %points40 = load i32, i32* %points
  %Asn41 = add i32 %le24, %points40
  store i32 %Asn41, i32* @"variable::score"
  %10 = load i32, i32* @"variable::score"
  %score = load i32, i32* @"variable::score"
  %numbers = load %objref, %objref* @"variable::numbers"
  %objptr_gen42 = extractvalue %objref %numbers, 1
  %objptr43 = bitcast %gameobj* %objptr_gen42 to %Draw*
  %width = getelementptr inbounds %Draw, %Draw* %objptr43, i32 0, i32 2
  %n = getelementptr inbounds %Draw, %Draw* %objptr43, i32 0, i32 3
  %y44 = getelementptr inbounds %Draw, %Draw* %objptr43, i32 0, i32 4
  %x45 = getelementptr inbounds %Draw, %Draw* %objptr43, i32 0, i32 5
  %spr46 = getelementptr inbounds %Draw, %Draw* %objptr43, i32 0, i32 6
  store i32 %score, i32* %n
  %11 = load i32, i32* %n
  %egg47 = load %objref, %objref* %ref
  %objptr48 = extractvalue %objref %egg47, 1
  %12 = bitcast %gameobj* %objptr48 to { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }**
  %tbl = load { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }*, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %12
  %eventptr = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 3
  %event = load void (%objref)*, void (%objref)** %eventptr
  %eventptr49 = getelementptr inbounds { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* %tbl, i32 0, i32 1
  %event50 = load void (%objref)*, void (%objref)** %eventptr49
  call void %event50(%objref %egg47)
  call void %event(%objref %egg47)
  %id51 = getelementptr inbounds %gameobj, %gameobj* %objptr48, i32 0, i32 2
  store i64 0, i64* %id51
  br label %block_end23

block_end23:                                      ; preds = %then22
  br label %merge21

else52:                                           ; preds = %then17
  br label %block_end53

block_end53:                                      ; preds = %else52
  br label %merge21

else54:                                           ; preds = %then15
  br label %merge16

else55:                                           ; preds = %while_body
  %cont56 = icmp eq %node* %curr, %tail
  br i1 %cont56, label %then58, label %else59

merge57:                                          ; preds = %else59, %then58
  br label %merge14

then58:                                           ; preds = %else55
  call void @list_rem(%node* %tail)
  call void @list_add(%node* %tail, %node* @"node.object::Egg.head")
  br label %merge57

else59:                                           ; preds = %else55
  br label %merge57
}

define void @"object::Player.event.create"(%objref %this) {
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
  %objptr2 = bitcast %gameobj* %objptr_gen to %Player*
  %this3 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.event.create"(%objref %this3, double 3.000000e+02, double 5.000000e+02, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @literal.2, i32 0, i32 0))
  %this4 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::obj.function.center_hitbox_prop"(%objref %this4, double 9.000000e-01, double 6.000000e-01)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%Player = type { %obj, %node }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Player*
  %objnode = getelementptr inbounds %Player, %Player* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Player, %Player* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %obj, %obj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %obj, %obj* %2, i32 0, i32 0
  %objnode2 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 1
  call void @list_rem(%node* %objnode2)
  %4 = getelementptr inbounds %gameobj, %gameobj* %3, i32 0, i32 0
  ret void
}

define void @"object::Spawner.event.step"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Spawner*
  %timer = getelementptr inbounds %Spawner, %Spawner* %objptr, i32 0, i32 2
  %le = load i32, i32* %timer
  %Asn = sub i32 %le, 1
  store i32 %Asn, i32* %timer
  %0 = load i32, i32* %timer
  %timer2 = load i32, i32* %timer
  %tmp = icmp eq i32 %timer2, 0
  br i1 %tmp, label %then, label %else40

block_end:                                        ; preds = %merge
  ret void

merge:                                            ; preds = %block_end41, %block_end3
  br label %block_end

then:                                             ; preds = %entry
  %times = load i32, i32* @"variable::times"
  %tmp4 = sdiv i32 %times, 8
  %tmp5 = sub i32 50, %tmp4
  store i32 %tmp5, i32* %timer
  %1 = load i32, i32* %timer
  %timer6 = load i32, i32* %timer
  %tmp7 = icmp slt i32 %timer6, 8
  br i1 %tmp7, label %then9, label %else

block_end3:                                       ; preds = %merge20
  br label %merge

merge8:                                           ; preds = %block_end10, %then9
  %le11 = load i32, i32* @"variable::times"
  %Asn12 = add i32 %le11, 1
  store i32 %Asn12, i32* @"variable::times"
  %2 = load i32, i32* @"variable::times"
  %range = alloca i32
  store i32 300, i32* %range
  %x = alloca i32
  %range13 = load i32, i32* %range
  %3 = sitofp i32 %range13 to double
  %frandom_result = call double @"function:file-../../lib/math.mg::frandom"()
  %tmp14 = fmul double %3, %frandom_result
  %range15 = load i32, i32* %range
  %4 = sitofp i32 %range15 to double
  %tmp16 = fmul double %4, 5.000000e-01
  %tmp17 = fsub double %tmp14, %tmp16
  %tmp18 = fadd double 4.000000e+02, %tmp17
  %5 = fptosi double %tmp18 to i32
  store i32 %5, i32* %x
  %irandom_result = call i32 @"function:file-../../lib/math.mg::irandom"(i32 5)
  %tmp19 = icmp eq i32 %irandom_result, 0
  br i1 %tmp19, label %then21, label %else26

then9:                                            ; preds = %then
  store i32 8, i32* %timer
  %6 = load i32, i32* %timer
  br label %merge8

else:                                             ; preds = %then
  br label %block_end10

block_end10:                                      ; preds = %else
  br label %merge8

merge20:                                          ; preds = %else26, %then21
  br label %block_end3

then21:                                           ; preds = %merge8
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%SineEgg* getelementptr (%SineEgg, %SineEgg* null, i32 1) to i32))
  %SineEgg = bitcast i8* %malloccall to %SineEgg*
  store %SineEgg zeroinitializer, %SineEgg* %SineEgg
  %SineEgg_gen = bitcast %SineEgg* %SineEgg to %gameobj*
  %SineEgg_objnode = getelementptr inbounds %SineEgg, %SineEgg* %SineEgg, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %SineEgg_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %SineEgg_objnode, %node* @"node.object::SineEgg.head")
  %SineEgg_parent = getelementptr inbounds %SineEgg, %SineEgg* %SineEgg, i32 0, i32 0
  %Egg_objnode = getelementptr inbounds %Egg, %Egg* %SineEgg_parent, i32 0, i32 1
  %marker22 = getelementptr inbounds %node, %node* %Egg_objnode, i32 0, i32 2
  store i1 true, i1* %marker22
  call void @list_add(%node* %Egg_objnode, %node* @"node.object::Egg.head")
  %Egg_parent = getelementptr inbounds %Egg, %Egg* %SineEgg_parent, i32 0, i32 0
  %obj_objnode = getelementptr inbounds %obj, %obj* %Egg_parent, i32 0, i32 1
  %marker23 = getelementptr inbounds %node, %node* %obj_objnode, i32 0, i32 2
  store i1 true, i1* %marker23
  call void @list_add(%node* %obj_objnode, %node* @"node.object:file-../../lib/game.mg::obj.head")
  %obj_parent = getelementptr inbounds %obj, %obj* %Egg_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %obj_parent, i32 0, i32 1
  %marker24 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker24
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %obj_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %7 = getelementptr inbounds %gameobj, %gameobj* %SineEgg_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @SineEgg.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %7
  %8 = getelementptr inbounds %gameobj, %gameobj* %SineEgg_gen, i32 0, i32 2
  store i64 %new_id, i64* %8
  %9 = insertvalue %objref undef, i64 %new_id, 0
  %10 = insertvalue %objref %9, %gameobj* %SineEgg_gen, 1
  %x25 = load i32, i32* %x
  %11 = sitofp i32 %x25 to double
  call void @"object::SineEgg.event.create"(%objref %10, double %11, double 0.000000e+00)
  br label %merge20

else26:                                           ; preds = %merge8
  %malloccall27 = tail call i8* @malloc(i32 ptrtoint (%Egg* getelementptr (%Egg, %Egg* null, i32 1) to i32))
  %Egg = bitcast i8* %malloccall27 to %Egg*
  store %Egg zeroinitializer, %Egg* %Egg
  %Egg_gen = bitcast %Egg* %Egg to %gameobj*
  %Egg_objnode28 = getelementptr inbounds %Egg, %Egg* %Egg, i32 0, i32 1
  %marker29 = getelementptr inbounds %node, %node* %Egg_objnode28, i32 0, i32 2
  store i1 true, i1* %marker29
  call void @list_add(%node* %Egg_objnode28, %node* @"node.object::Egg.head")
  %Egg_parent30 = getelementptr inbounds %Egg, %Egg* %Egg, i32 0, i32 0
  %obj_objnode31 = getelementptr inbounds %obj, %obj* %Egg_parent30, i32 0, i32 1
  %marker32 = getelementptr inbounds %node, %node* %obj_objnode31, i32 0, i32 2
  store i1 true, i1* %marker32
  call void @list_add(%node* %obj_objnode31, %node* @"node.object:file-../../lib/game.mg::obj.head")
  %obj_parent33 = getelementptr inbounds %obj, %obj* %Egg_parent30, i32 0, i32 0
  %object_objnode34 = getelementptr inbounds %gameobj, %gameobj* %obj_parent33, i32 0, i32 1
  %marker35 = getelementptr inbounds %node, %node* %object_objnode34, i32 0, i32 2
  store i1 true, i1* %marker35
  call void @list_add(%node* %object_objnode34, %node* @node.gameobj.head)
  %object_parent36 = getelementptr inbounds %gameobj, %gameobj* %obj_parent33, i32 0, i32 0
  %old_id37 = load i64, i64* @last_objid
  %new_id38 = add i64 %old_id37, 1
  store i64 %new_id38, i64* @last_objid
  %12 = getelementptr inbounds %gameobj, %gameobj* %Egg_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Egg.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %12
  %13 = getelementptr inbounds %gameobj, %gameobj* %Egg_gen, i32 0, i32 2
  store i64 %new_id38, i64* %13
  %14 = insertvalue %objref undef, i64 %new_id38, 0
  %15 = insertvalue %objref %14, %gameobj* %Egg_gen, 1
  %x39 = load i32, i32* %x
  %16 = sitofp i32 %x39 to double
  call void @"object::Egg.event.create"(%objref %15, double %16, double 0.000000e+00)
  br label %merge20

else40:                                           ; preds = %entry
  br label %block_end41

block_end41:                                      ; preds = %else40
  br label %merge
}

define void @"object::Spawner.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %Spawner*
  %timer = getelementptr inbounds %Spawner, %Spawner* %objptr, i32 0, i32 2
  store i32 50, i32* %timer
  %0 = load i32, i32* %timer
  store i32 0, i32* @"variable::times"
  %1 = load i32, i32* @"variable::times"
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%Spawner = type { %gameobj, %node, i32 }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %Spawner*
  %objnode = getelementptr inbounds %Spawner, %Spawner* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %Spawner, %Spawner* %1, i32 0, i32 0
  %objnode1 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 1
  call void @list_rem(%node* %objnode1)
  %3 = getelementptr inbounds %gameobj, %gameobj* %2, i32 0, i32 0
  ret void
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
  call void @"function:file-../../lib/window.mg::set_title"(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @literal.3, i32 0, i32 0))
  store i32 0, i32* @"variable::score"
  %0 = load i32, i32* @"variable::score"
  %load_result = call %sfSound* @"function:file-../../lib/sound.mg::load"(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @literal.4, i32 0, i32 0))
  store %sfSound* %load_result, %sfSound** @"variable::boinkSound"
  %1 = load %sfSound*, %sfSound** @"variable::boinkSound"
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%Player* getelementptr (%Player, %Player* null, i32 1) to i32))
  %Player = bitcast i8* %malloccall to %Player*
  store %Player zeroinitializer, %Player* %Player
  %Player_gen = bitcast %Player* %Player to %gameobj*
  %Player_objnode = getelementptr inbounds %Player, %Player* %Player, i32 0, i32 1
  %marker = getelementptr inbounds %node, %node* %Player_objnode, i32 0, i32 2
  store i1 true, i1* %marker
  call void @list_add(%node* %Player_objnode, %node* @"node.object::Player.head")
  %Player_parent = getelementptr inbounds %Player, %Player* %Player, i32 0, i32 0
  %obj_objnode = getelementptr inbounds %obj, %obj* %Player_parent, i32 0, i32 1
  %marker4 = getelementptr inbounds %node, %node* %obj_objnode, i32 0, i32 2
  store i1 true, i1* %marker4
  call void @list_add(%node* %obj_objnode, %node* @"node.object:file-../../lib/game.mg::obj.head")
  %obj_parent = getelementptr inbounds %obj, %obj* %Player_parent, i32 0, i32 0
  %object_objnode = getelementptr inbounds %gameobj, %gameobj* %obj_parent, i32 0, i32 1
  %marker5 = getelementptr inbounds %node, %node* %object_objnode, i32 0, i32 2
  store i1 true, i1* %marker5
  call void @list_add(%node* %object_objnode, %node* @node.gameobj.head)
  %object_parent = getelementptr inbounds %gameobj, %gameobj* %obj_parent, i32 0, i32 0
  %old_id = load i64, i64* @last_objid
  %new_id = add i64 %old_id, 1
  store i64 %new_id, i64* @last_objid
  %2 = getelementptr inbounds %gameobj, %gameobj* %Player_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Player.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %2
  %3 = getelementptr inbounds %gameobj, %gameobj* %Player_gen, i32 0, i32 2
  store i64 %new_id, i64* %3
  %4 = insertvalue %objref undef, i64 %new_id, 0
  %5 = insertvalue %objref %4, %gameobj* %Player_gen, 1
  call void @"object::Player.event.create"(%objref %5)
  %malloccall6 = tail call i8* @malloc(i32 ptrtoint (%Spawner* getelementptr (%Spawner, %Spawner* null, i32 1) to i32))
  %Spawner = bitcast i8* %malloccall6 to %Spawner*
  store %Spawner zeroinitializer, %Spawner* %Spawner
  %Spawner_gen = bitcast %Spawner* %Spawner to %gameobj*
  %Spawner_objnode = getelementptr inbounds %Spawner, %Spawner* %Spawner, i32 0, i32 1
  %marker7 = getelementptr inbounds %node, %node* %Spawner_objnode, i32 0, i32 2
  store i1 true, i1* %marker7
  call void @list_add(%node* %Spawner_objnode, %node* @"node.object::Spawner.head")
  %Spawner_parent = getelementptr inbounds %Spawner, %Spawner* %Spawner, i32 0, i32 0
  %object_objnode8 = getelementptr inbounds %gameobj, %gameobj* %Spawner_parent, i32 0, i32 1
  %marker9 = getelementptr inbounds %node, %node* %object_objnode8, i32 0, i32 2
  store i1 true, i1* %marker9
  call void @list_add(%node* %object_objnode8, %node* @node.gameobj.head)
  %object_parent10 = getelementptr inbounds %gameobj, %gameobj* %Spawner_parent, i32 0, i32 0
  %old_id11 = load i64, i64* @last_objid
  %new_id12 = add i64 %old_id11, 1
  store i64 %new_id12, i64* @last_objid
  %6 = getelementptr inbounds %gameobj, %gameobj* %Spawner_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Spawner.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %6
  %7 = getelementptr inbounds %gameobj, %gameobj* %Spawner_gen, i32 0, i32 2
  store i64 %new_id12, i64* %7
  %8 = insertvalue %objref undef, i64 %new_id12, 0
  %9 = insertvalue %objref %8, %gameobj* %Spawner_gen, 1
  call void @"object::Spawner.event.create"(%objref %9)
  %malloccall13 = tail call i8* @malloc(i32 ptrtoint (%Draw* getelementptr (%Draw, %Draw* null, i32 1) to i32))
  %Draw = bitcast i8* %malloccall13 to %Draw*
  store %Draw zeroinitializer, %Draw* %Draw
  %Draw_gen = bitcast %Draw* %Draw to %gameobj*
  %Draw_objnode = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 1
  %marker14 = getelementptr inbounds %node, %node* %Draw_objnode, i32 0, i32 2
  store i1 true, i1* %marker14
  call void @list_add(%node* %Draw_objnode, %node* @"node.object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.head")
  %Draw_parent = getelementptr inbounds %Draw, %Draw* %Draw, i32 0, i32 0
  %object_objnode15 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 1
  %marker16 = getelementptr inbounds %node, %node* %object_objnode15, i32 0, i32 2
  store i1 true, i1* %marker16
  call void @list_add(%node* %object_objnode15, %node* @node.gameobj.head)
  %object_parent17 = getelementptr inbounds %gameobj, %gameobj* %Draw_parent, i32 0, i32 0
  %old_id18 = load i64, i64* @last_objid
  %new_id19 = add i64 %old_id18, 1
  store i64 %new_id19, i64* @last_objid
  %10 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 0
  store { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }* @Draw.vtable, { void (%objref)*, void (%objref)*, void (%objref)*, void (%objref)* }** %10
  %11 = getelementptr inbounds %gameobj, %gameobj* %Draw_gen, i32 0, i32 2
  store i64 %new_id19, i64* %11
  %12 = insertvalue %objref undef, i64 %new_id19, 0
  %13 = insertvalue %objref %12, %gameobj* %Draw_gen, 1
  call void @"object:file-/home/steven/Files/Desktop/Schoolwork/7/plt/makergame/demo/egg/draw_numbers.mg::Draw.event.create"(%objref %13, i32 0, double 1.000000e+01, double 1.000000e+01)
  store %objref %13, %objref* @"variable::numbers"
  %14 = load %objref, %objref* @"variable::numbers"
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

define void @"object::gameover.event.draw"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %gameover*
  %spr = getelementptr inbounds %gameover, %gameover* %objptr2, i32 0, i32 2
  %spr3 = load %sfSprite*, %sfSprite** %spr
  call void @"function:file-../../lib/sprite.mg::render"(%sfSprite* %spr3, double 0.000000e+00, double 0.000000e+00)
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"object::gameover.event.create"(%objref %this) {
entry:
  %this1 = alloca %objref
  store %objref %this, %objref* %this1
  %thisref = load %objref, %objref* %this1
  %objptr_gen = extractvalue %objref %thisref, 1
  %objptr = bitcast %gameobj* %objptr_gen to %room*
  %objptr2 = bitcast %gameobj* %objptr_gen to %gameover*
  %spr = getelementptr inbounds %gameover, %gameover* %objptr2, i32 0, i32 2
  %this3 = load %objref, %objref* %this1
  call void @"object:file-../../lib/game.mg::room.event.create"(%objref %this3)
  %load_result = call %sfSprite* @"function:file-../../lib/sprite.mg::load"(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @literal.5, i32 0, i32 0))
  store %sfSprite* %load_result, %sfSprite** %spr
  %0 = load %sfSprite*, %sfSprite** %spr
  br label %block_end

block_end:                                        ; preds = %entry
  ret void
}

define void @"delete_%gameover = type { %room, %node, %sfSprite* }"(%objref) {
entry:
  %objptr = extractvalue %objref %0, 1
  %1 = bitcast %gameobj* %objptr to %gameover*
  %objnode = getelementptr inbounds %gameover, %gameover* %1, i32 0, i32 1
  call void @list_rem(%node* %objnode)
  %2 = getelementptr inbounds %gameover, %gameover* %1, i32 0, i32 0
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
