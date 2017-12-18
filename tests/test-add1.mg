int add(int x, int y)
{
  return x + y;
}

object main {
event create
{
  std::print::i( add(17, 25) );

  std::end_game();
}
}
