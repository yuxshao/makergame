// standard external functions from the library
// TODO: unify print names and their tests
extern void print(int x);
extern void printb(bool x);
extern void print_float(float x);
extern void printstr(string x);

extern sprite load_image(string filename);
extern sound load_sound(string filename);
extern void play_sound(sound snd);
extern void draw_sprite(sprite spr, float x, float y);
extern int irandom(int x);

extern void set_window_size(int w, int h);
extern void set_window_clear(int r, int g, int b);
extern void set_window_title(string x);

namespace key = open "key.mg";

bool is_alive (object o) {
  foreach (object x)
    if (x == o) return true;
  return false;
}

// Game room initialization
object room {
  event create {
    foreach (object r) { if (r != this) destroy r; }
    key::set_key();
  }
}

extern void end_game();
