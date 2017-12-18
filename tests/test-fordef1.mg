object main {
  event create
  {
    for (int i = 0 ; i < 5 ; i = i + 1)
      std::print::i(i);
    std::game::end();
    return;
  }
}
