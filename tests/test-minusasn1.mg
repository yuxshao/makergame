
int minusAsn(int x)
{
  return x -= 2;
}

object main {
event create
{
  std::print( minusAsn(2) );

  std::end_game();
  return;
}
}
