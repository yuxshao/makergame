object main {
event create
{
  int i = 0;
  for(; i < 5; i = i + 1)
    std::print::i(i);
  std::print::i(i);
  std::end_game();
  return;
}
}
