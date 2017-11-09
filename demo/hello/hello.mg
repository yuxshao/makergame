extern sprite load_image(string filename);
extern sound load_sound(string filename);
extern void play_sound(sound snd);
extern void set_sprite_position(sprite spr, float x, float y);
extern void draw_sprite(sprite spr);
extern void end_game();
extern float to_dbl(int x);
extern bool key_pressed(int x);

sound snd;

timer {
int time;
create {
this.time = 0;
}

step {
this.time = this.time + 1;
}
}

main {
int x;
int y;
sprite spr;
timer mytimer;
bool dead;
create {
  snd = load_sound("trial/boing.ogx");
  this.dead = false;
  this.x = 0;
  this.y = 50;
  this.mytimer = create timer;
  this.spr = load_image("trial/cute_image.png");
  printstr("hello");
}
step {
  if (this.x >= 60) { printstr("are you there"); this.x = 0; play_sound(snd); }
  if (key_pressed(73)) this.y = this.y - 1;
  if (key_pressed(74)) this.y = this.y + 1;
  set_sprite_position(this.spr, to_dbl(this.x), to_dbl(this.y));
  if (this.dead) this.x = this.x + 1;
  else if (this.mytimer.time > 30) { this.x = this.x + 1; this.dead = true; destroy this.mytimer; }
}
draw { draw_sprite(this.spr); }
}
