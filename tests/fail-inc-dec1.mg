object main {
  event create {
    std::print::i(++42);
    std::print::i(--42);
    std::game::end();
  }
}
