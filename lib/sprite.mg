private namespace p {
  extern sprite load_image(string filename);
  extern void draw_sprite(sprite spr, float x, float y);
  extern void draw_sprite_rect(sprite spr, float x, float y, int sx, int sy, int sw, int sh);
  extern int sprite_width(sprite spr);
  extern int sprite_height(sprite spr);
}

sprite load(string filename) { return p::load_image(filename); }
int width(sprite s) { return p::sprite_width(s); }
int height(sprite s) { return p::sprite_height(s); }
void render(sprite s, float x, float y) { p::draw_sprite(s, x, y); }
void render_rect(sprite s, float x, float y, int rect[4]) {
  p::draw_sprite_rect(s, x, y, rect[0], rect[1], rect[2], rect[3]);
}
