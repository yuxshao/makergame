object main {
event create
{
  int i = 0;
  for (int i = 1; i < 5 ; i = i + 1)
    std::print(i);
  std::print(i);
  std::end_game();
  return;
}
}

