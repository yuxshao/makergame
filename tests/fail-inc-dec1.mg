object main {
  event create {
    std::print(++42);
    std::print(--42);
    std::end_game();
  }
}
