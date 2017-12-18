object main {
event create
{
  int i;
  i = 0;
  for ( ; i < 5; ) {
    std::print::i(i);
    i = i + 1;
  }
  std::print::i(42);
  std::game::end();
  return;
}
}
