sprite playerSprite;
sprite eggSprite;
sound boinkSound;
int score;

bool hit_ground(Egg e) { return (e.y > 600); }
bool egg_touching_player(Egg e, Player p) {
  return (e.x < p.x + 50 && e.x > p.x - 50 && e.y < p.y + 10 && e.y > p.y - 10);
}

object Egg {
  int x; int y;
  event create { std::play_sound(boinkSound); } 
  event step {
    y = y + 5;
    if (hit_ground(this)) {
      foreach (Egg o) destroy o;
      foreach (Player p) destroy p;
      foreach (Spawner s) destroy s;
      foreach (main g) destroy g;
      create Gameover;
    }
  }
  event draw {
    std::draw_sprite(eggSprite, x-16, y-16);
  }
}

object Player {
  int x; int y;

  event create { x = 300; y = 500; }
  event step { 
    if (std::key::is_down(std::key::Left)) x -= 5;
    if (std::key::is_down(std::key::Right)) x += 5;

    foreach (Egg egg) {
      if (egg_touching_player(egg, this)) {
        destroy egg;
        score += 5;
        std::print(score);
      }
    }
  }

  event draw {
    std::draw_sprite(playerSprite, x-50, y-16);
  }
}

object Spawner {
  int timer;
  event create { timer = 50; }
  event step {
    --timer;
    if (timer == 0) {
      timer = 50;
      Egg egg = create Egg;
      egg.x = 100 + 100 * std::irandom(7);
      egg.y = 0;
    }
  }
}

object main : std::room {
  event create {
    super();
    score = 0;
    playerSprite = std::load_image("player.png");
    eggSprite = std::load_image("egg.png");
    boinkSound = std::load_sound("boink.ogx");
    create Player;
    create Spawner;
  }
}

object Gameover {
  sprite s;
  event create { s = std::load_image("gameover.png"); }
  event draw { std::draw_sprite(s, 0, 0); }
}
