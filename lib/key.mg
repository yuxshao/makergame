int A;
int B;
int C;
int D;
int E;
int F;
int G;
int H;
int I;
int J;
int K;
int L;
int M;
int N;
int O;
int P;
int Q;
int R;
int S;
int T;
int U;
int V;
int W;
int X;
int Y;
int Z;
int Num0;
int Num1;
int Num2;
int Num3;
int Num4;
int Num5;
int Num6;
int Num7;
int Num8;
int Num9;
int Escape;
int LControl;
int LShift;
int LAlt;
int LSystem;
int RControl;
int RShift;
int RAlt;
int RSystem;
int Menu;
int LBracket;
int RBracket;
int SemiColon;
int Comma;
int Period;
int Quote;
int Slash;
int BackSlash;
int Tilde;
int Equal;
int Dash;
int Space;
int Return;
int BackSpace;
int Tab;
int PageUp;
int PageDown;
int End;
int Home;
int Insert;
int Delete;
int Add;
int Subtract;
int Multiply;
int Divide;
int Left;
int Right;
int Up;
int Down;
int Numpad0;
int Numpad1;
int Numpad2;
int Numpad3;
int Numpad4;
int Numpad5;
int Numpad6;
int Numpad7;
int Numpad8;
int Numpad9;
int F1;
int F2;
int F3;
int F4;
int F5;
int F6;
int F7;
int F8;
int F9;
int F10;
int F11;
int F12;
int F13;
int F14;
int F15;
int Pause;

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
  A             = 0;
  B             = 1;
  C             = 2;
  D             = 3;
  E             = 4;
  F             = 5;
  G             = 6;
  H             = 7;
  I             = 8;
  J             = 9;
  K             = 10;
  L             = 11;
  M             = 12;
  N             = 13;
  O             = 14;
  P             = 15;
  Q             = 16;
  R             = 17;
  S             = 18;
  T             = 19;
  U             = 20;
  V             = 21;
  W             = 22;
  X             = 23;
  Y             = 24;
  Z             = 25;
  Num0          = 26;
  Num1          = 27;
  Num2          = 28;
  Num3          = 29;
  Num4          = 30;
  Num5          = 31;
  Num6          = 32;
  Num7          = 33;
  Num8          = 34;
  Num9          = 35;
  Escape        = 36;
  LControl      = 37;
  LShift        = 38;
  LAlt          = 39;
  LSystem       = 40;
  RControl      = 41;
  RShift        = 42;
  RAlt          = 43;
  RSystem       = 44;
  Menu          = 45;
  LBracket      = 46;
  RBracket      = 47;
  SemiColon     = 48;
  Comma         = 49;
  Period        = 50;
  Quote         = 51;
  Slash         = 52;
  BackSlash     = 53;
  Tilde         = 54;
  Equal         = 55;
  Dash          = 56;
  Space         = 57;
  Return        = 58;
  BackSpace     = 59;
  Tab           = 60;
  PageUp        = 61;
  PageDown      = 62;
  End           = 63;
  Home          = 64;
  Insert        = 65;
  Delete        = 66;
  Add           = 67;
  Subtract      = 68;
  Multiply      = 69;
  Divide        = 70;
  Left          = 71;
  Right         = 72;
  Up            = 73;
  Down          = 74;
  Numpad0       = 75;
  Numpad1       = 76;
  Numpad2       = 77;
  Numpad3       = 78;
  Numpad4       = 79;
  Numpad5       = 80;
  Numpad6       = 81;
  Numpad7       = 82;
  Numpad8       = 83;
  Numpad9       = 84;
  F1            = 85;
  F2            = 86;
  F3            = 87;
  F4            = 88;
  F5            = 89;
  F6            = 90;
  F7            = 91;
  F8            = 92;
  F9            = 93;
  F10           = 94;
  F11           = 95;
  F12           = 96;
  F13           = 97;
  F14           = 98;
  F15           = 99;
  Pause         = 100;
}
