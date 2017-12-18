object main {
event create
{
  int i;
  for (i = 0 ; i < 5 ; i = i + 1) {
    std::print::i(i);
  }
  std::print::i(42);
  std::game::end();
  return;
}
}
