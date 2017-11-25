int addAsn(int x)
{
  int y;
  y = ((x += 2) = 3);
  return y;
}

object main {
event create
{
  std::print( addAsn(1) );

  std::end_game();
}
}
