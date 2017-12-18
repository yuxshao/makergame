
object parent { }
object child : parent { }

object main {
  event create {
    for (int i = 0; i < 10; ++i)
      create parent;

    for (int i = 0; i < 10; ++i)
      create child;

    int i = 0;
    foreach (parent p) ++i; // 20 parents total
    std::print::i(i);

    i = 0;
    foreach (child c) ++i; // 10 parents total
    std::print::i(i);

    std::game::end();
  }
}

