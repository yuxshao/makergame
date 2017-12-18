private namespace p {
  extern sprite load_image(string filename);
  extern void draw_sprite(sprite spr, float x, float y);
  extern int sprite_width(sprite spr);
  extern int sprite_height(sprite spr);
}

sprite load(string filename) { return p::load_image(filename); }
int width(sprite s) { return p::sprite_width(s); }
int height(sprite s) { return p::sprite_height(s); }
void render(sprite s, float x, float y) { p::draw_sprite(s, x, y); }
