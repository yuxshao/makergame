object main {
  event create {
    std::print::i(++42);
    std::print::i(--42);
    std::end_game();
  }
}
