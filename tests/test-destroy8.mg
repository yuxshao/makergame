object parent {
  void detonate() { destroy this; }
}

object child : parent { }

object main {
  int j;
  event create { j = 0; }
  event step {
    // Create 10 children, then destroy them using
    // handles to the parent
    for (int i = 0; i < 10; ++i) create child;
    for (int i = 0; i < 10; ++i) create parent;
    int i = 0;
    foreach (child c) c.detonate();
    foreach (parent c) ++i;
    std::print(i);

    // run this thing for 6 steps
    ++j;
    if (j >= 6)
      std::end_game();
  }
}
