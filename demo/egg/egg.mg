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

namespace Num = open "draw_numbers.mg";
Num::Draw numbers;

sound boinkSound;
int score;

object Egg : game::obj {
  int points;

  event create(float x, float y) {
    super(x, y, "egg.png");
    vspeed = 3 + std::math::frandom() * (1.4 + times * 0.02);
    points = vspeed * 10;
    snd::play(boinkSound);
    center_hitbox_prop(0.9, 0.9);
  }

  event step {
    if (y > 600) create gameover; // go to the room
  }
}

object SineEgg : Egg {
  int timer;

  event create(float x, float y) {
    super(x, y);
    points *= 1.5;
    timer = 0;
    spr = spr::load("flying-egg.png");
    hitbox_offx = -spr::width(spr)/2;
    hitbox_offy = -spr::height(spr)/2;
  }

  event step {
    super();
    ++timer;
    hspeed = 5 * std::math::sin(timer * 0.1);
  }
}

object Player : game::obj {
  event create {
    super(300, 500, "player.png");
    center_hitbox_prop(0.9, 0.6);
  }

  event step { 
    if (key::is_down(key::Left)) x -= 5;
    if (key::is_down(key::Right)) x += 5;

    foreach (Egg egg) {
      if (game::colliding(egg, this)) {
        score += egg.points;
        numbers.n = score;
        destroy egg;
      }
    }
  }
}

int times = 0; // to keep track of progress
object Spawner {
  int timer;
  event create { timer = 50; times = 0; }
  event step {
    --timer;
    if (timer == 0) {
      timer = 50 - times/8;
      if (timer < 8) timer = 8;
      ++times;
      int range = 300;
      int x = 400 + (range * std::math::frandom() - range * 0.5);
      if (std::math::irandom(5) == 0) create SineEgg(x, 0);
      else create Egg(x, 0);
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
    numbers = create Num::Draw(0, 10, 10);
  }
}

object gameover : game::room {
  sprite spr;
  event create {
    super();
    spr = spr::load("gameover.png");
  }
  event draw { spr::render(spr, 0, 0); }
}
