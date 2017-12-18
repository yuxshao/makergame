
object helper {
  int y;
  event create { this.y = 3; }
  event destroy { std::print::i(this.y); std::game::end(); }
}

object main {
  int y;
  helper h;
  event create { this.h = create helper; }
  event step {
    destroy this.h;
  }
}
