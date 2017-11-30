// constructors with parameters
object helper {
  int x;
  event create(int x) {
    this.x = x;
  }
}

object main {
  event create {
    helper h;
    h = create helper(4);
    std::print(h.x);
    std::end_game();
  }
}

