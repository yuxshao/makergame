// make relevant namespaces more easily accessible
namespace spr = std::spr;
namespace snd = std::snd;
namespace key = std::key;
namespace window = std::window;

sound boinkSound;
int score;

bool hit_ground(Egg e) { return (e.y > 600); }
bool egg_touching_player(Egg e, Player p) {
  return (e.x < p.x + 50 && e.x > p.x - 50 && e.y < p.y + 10 && e.y > p.y - 10);
}

object Gameobj {
  sprite spr;
  float x; float y;
  float hspeed; float vspeed;
  float origin_x; float origin_y;

  event create(string sprite_name) {
    spr = spr::load(sprite_name);
    origin_x = spr::width(spr) * 0.5;
    origin_y = spr::height(spr) * 0.5;
  }
  event draw {
    x += hspeed; y += vspeed;
    spr::render(spr, x-origin_x, y-origin_y);
  }
}

object Egg {
  sprite spr;
  int x; int y;
  event create {
    spr = spr::load("egg.png");
    snd::play(boinkSound);
  }

  event step {
    y = y + 5;
    if (hit_ground(this)) {
      foreach (object o) destroy o;
      create Gameover;
    }
  }
  event draw {
    spr::render(spr, x-16, y-16);
  }
}

object Player {
  int x; int y;
  sprite spr;

  event create {
    spr = spr::load("player.png");
    x = 300;
    y = 500;
  }

  event step { 
    if (key::is_down(key::Left)) x -= 5;
    if (key::is_down(key::Right)) x += 5;

    foreach (Egg egg) {
      if (egg_touching_player(egg, this)) {
        destroy egg;
        score += 5;
        std::print::i(score);
      }
    }
  }

  event draw {
    spr::render(spr, x-50, y-16);
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
      egg.x = 100 + 100 * std::math::irandom(7);
      egg.y = 0;
    }
  }
}

object main : std::room {
  event create {
    super();
    std::window::set_title("egg game");
    score = 0;
    boinkSound = snd::load("boink.ogx");
    create Player;
    create Spawner;
  }
}

object Gameover {
  sprite spr;
  event create { spr = spr::load("gameover.png"); }
  event draw { spr::render(spr, 0, 0); }
}
