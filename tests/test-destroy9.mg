// sort of minimal example of bug in past
namespace game = std::game;

object A {
  event create { std::print::s("create A"); }
  event step { std::print::s("step A"); }
  event destroy { std::print::s("destroy A"); }
}
object main {
  int x;
  event create { x = 0; }
  event step { ++x; if (x > 5) { destroy this; create maind; create A; } }
}
object maind {
  event create {
    std::print::s("create maind");
    // create A;
  }

  event step { create gameover; }

  event destroy { std::print::s("destroy maind"); }
}

object gameover {
  int i;
  event create {
    std::print::s("create gameover");
    i = 0;
    foreach (object r) { if (r != this) { destroy r; } }
    foreach (object r) { std::print::s("loop alive"); }
  }

  event step {
    ++i;
    foreach (object r) { std::print::s("step alive"); }
    if (i > 5)
      std::game::end();
  }
}
