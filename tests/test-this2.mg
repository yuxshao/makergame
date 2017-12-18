
void set(main m) {
  m.x = 3;
}

object main {
  int x;
  event create {
    set(this);
    std::print::i(this.x);
    std::game::end();
  }
}
