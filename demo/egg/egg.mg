extern sprite load_image(string filename);
extern sound load_sound(string filename);
extern void play_sound(sound snd);
extern void set_sprite_position(sprite spr, float x, float y);
extern void draw_sprite(sprite spr);
extern void end_game();
extern float to_dbl(int x);
extern bool key_pressed(int x);
extern int irandom(int x);

sprite playerSprite;
sprite eggSprite;
sound boinkSound;
int score;

bool hit_ground(Egg e) { return (e.y > 600); }
bool egg_touching_player(Egg e, Player p) {
  return (e.x < p.x + 50 && e.x > p.x - 50 && e.y < p.y + 10 && e.y > p.y - 10);
}

Egg {
  int x; int y;
  create { play_sound(boinkSound); } 
  step {
    this.y = this.y + 5;
    if (hit_ground(this)) {
      foreach (Egg o) destroy o;
      foreach (Player p) destroy p;
      foreach (Spawner s) destroy s;
      foreach (main g) destroy g;
      create Gameover;
    }
  }
  draw {
    set_sprite_position(eggSprite, to_dbl(this.x - 16), to_dbl(this.y - 16));
    draw_sprite(eggSprite);
  }
}

Player {
  int x; int y;

  create { this.x = 300; this.y = 500; }
  step { 
    if (key_pressed(71)) this.x = this.x - 5;
    if (key_pressed(72)) this.x = this.x + 5;

    foreach (Egg egg) {
      if (egg_touching_player(egg, this)) {
        destroy egg;
        score = score + 5;
        print(score);
      }
    }
  }

  draw {
    set_sprite_position(playerSprite, to_dbl(this.x - 50), to_dbl(this.y - 16));
    draw_sprite(playerSprite);
  }
}

Spawner {
  int timer;
  create { this.timer = 50; }
  step {
    this.timer = this.timer - 1;
    if (this.timer == 0) {
      this.timer = 50;
      Egg egg;
      egg = create Egg;
      egg.x = 100 + 100 * irandom(7);
      egg.y = 0;
    }
  }
}

main {
  create {
    score = 0;
    playerSprite = load_image("player.png");
    eggSprite = load_image("egg.png");
    boinkSound = load_sound("boink.ogx");
    create Player;
    create Spawner;
  }
}

Gameover {
  sprite s;
  create { this.s = load_image("gameover.png"); }
  draw { draw_sprite(this.s); }
}
