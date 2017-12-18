// make relevant namespaces more easily accessible
// the best way is slightly verbose right now, since
// "using" does not make inner namespaces available
// (for deeper language design reasons... since declaration
//  order does not matter, it will be tough to decide how
//  to get using inner inner namespaces after using an inner
//  namespace.)
namespace spr    = std::spr;
namespace snd    = std::snd;
namespace key    = std::key;
namespace window = std::window;
namespace game   = std::game;

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

  event create(float x, float y, string sprite_name) {
    this.x = x; this.y = y;
    spr = spr::load(sprite_name);
    origin_x = spr::width(spr) * 0.5;
    origin_y = spr::height(spr) * 0.5;
  }
  event draw {
    x += hspeed; y += vspeed;
    spr::render(spr, x-origin_x, y-origin_y);
  }
}

object Egg : Gameobj {
  event create(float x, float y) {
    super(x, y, "egg.png");
    vspeed = 5;
    snd::play(boinkSound);
  }

  event step {
    if (hit_ground(this)) {
      foreach (object o) destroy o;
      create Gameover;
    }
  }
}

object Player : Gameobj {
  event create {
    super(300, 500, "player.png");
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
}

object Spawner {
  int timer;
  event create { timer = 50; }
  event step {
    --timer;
    if (timer == 0) {
      timer = 50;
      Egg egg = create Egg(100 + 700 * std::math::frandom(), 0);
    }
  }
}

object main : game::room {
  event create {
    super();
    window::set_title("egg game");
    score = 0;
    boinkSound = snd::load("boink.ogx");
    create Player;
    create Spawner;
  }
}

object Gameover : game::room {
  sprite spr;
  event create { spr = spr::load("gameover.png"); }
  event draw { spr::render(spr, 0, 0); }
}
