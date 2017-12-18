
object main {
  int x;
  event create { this.x = 3; }
  event step {
    int x;
    x = 5;
    std::print::i(this.x);
    std::print::i(x);
    std::game::end();
  }
}
