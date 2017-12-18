object helper { }
object main {
  event create {
    for (int i = 0; i < 5; ++i) create helper;
    int i = 0;
    // each of the helpers is identical only to itself
    foreach (helper h)
      foreach (helper g)
        if (h == g) ++i;
    std::print::i(i);
    std::game::end();
  }
}
