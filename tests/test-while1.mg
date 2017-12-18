object main {
event create
{
  int i;
  i = 5;
  while (i > 0) {
    std::print::i(i);
    i = i - 1;
  }
  std::print::i(42);
  std::end_game();
  return;
}
}
