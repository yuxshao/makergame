
object helper {
  int y;
  event create { this.y = 3; }
}

object main {
  int y;
  helper h;
  event create { this.y = 4; this.h = create helper; }
  event step {
    int y;
    y = 5;
    std::print(y);
    std::print(this.y);
    std::print(this.h.y);
    std::end_game();
  }
}
