int x;
object helper {
  int y;

  event create { x = x + 2; this.y = x; }
}

object main {
  int y;
  event create {
    this.y = 3; /* this is not std::printed since it's not a helper */

    int x;
    for (x = 0; x < 5; x = x + 1)
      create helper;

    foreach (helper h) {
      std::print(h.y);
    }

    std::end_game();
  }
}
