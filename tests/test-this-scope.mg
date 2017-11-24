
object main {
  int x;
  int y;
  event create {
    x = 0;
    this.y = 1;
    std::print(this.x);
    std::print(y);

    int y;
    y = 2;
    std::print(y);
    std::print(this.y);

    this.y = 3;
    std::print(y);
    std::print(this.y);

    std::end_game();
  }
}
