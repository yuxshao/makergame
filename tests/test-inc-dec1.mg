object main {
  event create {
    int a;
    a = 42;
    std::print::i(++a);
    ++a = 3;
    std::print::i(a);
    std::print::i(--a);
    std::print::i(--a + 5);
    std::game::end();
  }
}
