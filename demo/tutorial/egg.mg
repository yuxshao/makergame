int score = 0;
sound boinkSound;

object Spawner {
  int timer;
  int spawn_range;
  event create { timer = 50; spawn_range = 300; }
  event step {
    --timer;
    if (timer == 0) {
      timer = 50;
      spawn_egg();
    }
  }

  void spawn_egg() {
    // std::math::frandom() produces a real from 0 to 1
    int x = 400 + spawn_range * (std::math::frandom() - 0.5);
    Egg e = create Egg(x, 0);
    e.vspeed = 4 + std::math::frandom();
  }
}

object Player : std::game::obj {
  event create {
    super(400, 500, "res/player.png");
    center_hitbox_prop(0.8, 0.5);
  }

  event step {
    if (std::key::is_down(std::key::Left)) x -= 5;
    if (std::key::is_down(std::key::Right)) x += 5;
    foreach (Egg e) {
      if (std::game::colliding(e, this)) {
        destroy e;
        ++score;
        std::print::i(score);
      }
    }
  }
}

bool egg_touching_player(Egg e, Player p) {
  // compare the egg centre position to the player bounds
  return (e.x + 16 < p.x + 100 && e.x + 16 > p.x &&
          e.y + 16 < p.y + 10 && e.y + 16 > p.y - 10);
}

object Egg : std::game::obj {
  event create(int x, int y) {
    super(x, y, "res/egg.png");
    center_hitbox_prop(0.6, 0.6);
    vspeed = 5;
    std::snd::play(boinkSound);
  }

  event step {
    if (y > 600) create game_over;
  }
}

object main {
  event create {
    boinkSound = std::snd::load("res/boink.ogx");
    create Player;
    create Spawner;
  }
}

object game_over { // acts as a "state" or "room" in the game
  event create {
    // trick to remove every other object in the game
    foreach (object o) { if (o != this) destroy o; }
  }
  event step { if (std::key::is_down(std::key::Space)) std::game::end(); }
  event draw { std::spr::render(std::spr::load("res/gameover.png"), 0, 0); }
}
