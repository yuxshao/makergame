object parent {
  void detonate() { destroy this; }
}

object child : parent { }

object main {
  event create {
    for (int i = 0; i < 10; ++i) create child;
    for (int i = 0; i < 10; ++i) create parent;
    int i = 0;
    foreach (child c) c.detonate();
    foreach (parent c) ++i;
    std::print(i);
    i = 0;
    foreach (child c) ++i;
    std::print(i);
    std::end_game();
  }
}
