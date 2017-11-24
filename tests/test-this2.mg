
void set(main m) {
  m.x = 3;
}

object main {
  int x;
  event create {
    set(this);
    std::print(this.x);
    std::end_game();
  }
}
