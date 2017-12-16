int A         = 0;
int B         = 1;
int C         = 2;
int D         = 3;
int E         = 4;
int F         = 5;
int G         = 6;
int H         = 7;
int I         = 8;
int J         = 9;
int K         = 10;
int L         = 11;
int M         = 12;
int N         = 13;
int O         = 14;
int P         = 15;
int Q         = 16;
int R         = 17;
int S         = 18;
int T         = 19;
int U         = 20;
int V         = 21;
int W         = 22;
int X         = 23;
int Y         = 24;
int Z         = 25;
int Num0      = 26;
int Num1      = 27;
int Num2      = 28;
int Num3      = 29;
int Num4      = 30;
int Num5      = 31;
int Num6      = 32;
int Num7      = 33;
int Num8      = 34;
int Num9      = 35;
int Escape    = 36;
int LControl  = 37;
int LShift    = 38;
int LAlt      = 39;
int LSystem   = 40;
int RControl  = 41;
int RShift    = 42;
int RAlt      = 43;
int RSystem   = 44;
int Menu      = 45;
int LBracket  = 46;
int RBracket  = 47;
int SemiColon = 48;
int Comma     = 49;
int Period    = 50;
int Quote     = 51;
int Slash     = 52;
int BackSlash = 53;
int Tilde     = 54;
int Equal     = 55;
int Dash      = 56;
int Space     = 57;
int Return    = 58;
int BackSpace = 59;
int Tab       = 60;
int PageUp    = 61;
int PageDown  = 62;
int End       = 63;
int Home      = 64;
int Insert    = 65;
int Delete    = 66;
int Add       = 67;
int Subtract  = 68;
int Multiply  = 69;
int Divide    = 70;
int Left      = 71;
int Right     = 72;
int Up        = 73;
int Down      = 74;
int Numpad0   = 75;
int Numpad1   = 76;
int Numpad2   = 77;
int Numpad3   = 78;
int Numpad4   = 79;
int Numpad5   = 80;
int Numpad6   = 81;
int Numpad7   = 82;
int Numpad8   = 83;
int Numpad9   = 84;
int F1        = 85;
int F2        = 86;
int F3        = 87;
int F4        = 88;
int F5        = 89;
int F6        = 90;
int F7        = 91;
int F8        = 92;
int F9        = 93;
int F10       = 94;
int F11       = 95;
int F12       = 96;
int F13       = 97;
int F14       = 98;
int F15       = 99;
int Pause     = 100;

private namespace p {
  extern bool key_pressed(int x);

  // Define an object to store the state of key presses last step.
  // This way we can detect when a key is just pressed or just released.
  // TODO: have some way to get this into the game by default!
  object Checker {
    bool pressed[101];
    event create {
      for (int i = 0; i < 101; ++i) pressed[i] = false;
    }
    event draw {
      for (int i = 0; i < 101; ++i) pressed[i] = key_pressed(i);
    }
  }
  Checker c;
}

bool is_down(int x) { return p::key_pressed(x); }
bool is_pressed(int x) {
  return (p::key_pressed(x) && !p::c.pressed[x]); // down this frame but not last
}

bool is_released(int x) {
  return (!p::key_pressed(x) && p::c.pressed[x]); // down last frame but not this
}

void set_key() {
  p::c = create p::Checker;
}
