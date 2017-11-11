// SFML-independent environment for testing
static bool game_ended = false;

extern "C" {

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
