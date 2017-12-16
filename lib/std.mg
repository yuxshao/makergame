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

void goto_room (room r) {
  // TODO: some kind of iteration over all objects
  // destroy the current room / all objects
  // create the new room
}

object room {
  event create {
    // destroy all rooms but myself
    key::set_key();
  }

  event destroy {
    // destroy all objects
  }
}

extern void end_game();
