object main {
event create {
  int i;
  for (i = 0; i < 5; i = i + 1) {
    if (i == 2) { break; } // breaks out of loop
    std::print(i);
  }
  std::end_game();
}
}
