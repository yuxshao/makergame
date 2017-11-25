object main {
  event create {
    int a;
    a = 42;
    std::print(++a);
    ++a = 3;
    std::print(a);
    std::print(--a);
    std::print(--a + 5);
    std::end_game();
  }
}
