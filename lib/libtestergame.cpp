// SFML-independent environment for testing
#include <cstdio>
static bool game_ended = false;

extern "C" {

// built-in print functions
void print(int x) { printf("%d\n", x); }
void printb(bool x) { if (x) printf("true\n"); else printf("false\n"); }
void print_float(double x) { printf("%f\n", x); }
void printstr(char *x) { printf("%s\n", x); }

// dummy remainder functions
void *load_sound(const char *filename) { return nullptr; }
void play_sound(void *sound) { }
void loop_sound(void *sound) { }
void *load_image(const char *filename) { return nullptr; }
void set_sprite_position(void *s, double x, double y) { }
void draw_sprite(void *sprite) { }
void end_game() { game_ended = true; }
bool key_pressed(int code) { return false; }
void global_create();
void global_step();
void global_draw();

}

int main() {
  global_create();

  while (!game_ended) {
    global_step();
    global_draw();
  }

  return 0;
}
