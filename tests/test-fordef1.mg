object main {
  event create
  {
    for (int i = 0 ; i < 5 ; i = i + 1)
      std::print(i);
    std::end_game();
    return;
  }
}