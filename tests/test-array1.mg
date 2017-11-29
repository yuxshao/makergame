object main {
  event create {
    int j[10];
    int i;
    for (i = 0; i < 10; ++i)
      j[i] = i;
    std::print(j[3]);
    std::end_game();
  }
}
