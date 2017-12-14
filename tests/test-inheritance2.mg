object parent {
  int x;
  void compute() { std::print(x); }
}

object child : parent {
  event create { x = 3; compute(); } // overwrites parent x
}

object main {
  event create {
    child c = create child;
    c.x = 5;
    c.compute();
    std::end_game();
  }
}
