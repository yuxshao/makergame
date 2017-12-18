
object main {
  int x;
  int y;
  event create {
    x = 0;
    this.y = 1;
    std::print::i(this.x);
    std::print::i(y);

    int y;
    y = 2;
    std::print::i(y);
    std::print::i(this.y);

    this.y = 3;
    std::print::i(y);
    std::print::i(this.y);

    std::game::end();
  }
}
