// standard external functions from the library
// TODO: unify print names and their tests
extern void print(int x);
extern void printb(bool x);
extern void print_float(float x);
extern void printstr(string x);

extern sprite load_image(string filename);
extern sound load_sound(string filename);
extern void play_sound(sound snd);
extern void set_sprite_position(sprite spr, float x, float y);
extern void draw_sprite(sprite spr);
extern bool key_pressed(int x);
extern int irandom(int x);

extern void end_game();
