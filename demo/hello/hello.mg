sound snd;

object timer {
  int time;
  event create { this.time = 0; }
  event step { this.time = this.time + 1; }
}

object main {
  int x;
  int y;
  sprite spr;
  timer mytimer;
  bool dead;
  event create {
    snd = std::load_sound("trial/boing.ogx");
    this.dead = false;
    this.x = 0;
    this.y = 50;
    this.mytimer = create timer;
    this.spr = std::load_image("trial/cute_image.png");
    std::printstr("hello");
  }
  event step {
    if (this.x >= 60) {
      std::printstr("are you there");
      this.x = 0;
      std::play_sound(snd);
    }
    if (std::key_pressed(73)) this.y = this.y - 1;
    if (std::key_pressed(74)) this.y = this.y + 1;
    std::set_sprite_position(this.spr, this.x, this.y);
    if (this.dead) this.x = this.x + 1;
    else if (this.mytimer.time > 30) {
      this.x = this.x + 1; this.dead = true; destroy this.mytimer;
    }
  }
  event draw { std::draw_sprite(this.spr); }
}
