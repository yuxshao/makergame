
int minusAsn(int x)
{
  return (x -= 2) -= 2;
}

object main {
event create
{
  std::print( minusAsn(0) );

  std::end_game();
  return;
}
}
