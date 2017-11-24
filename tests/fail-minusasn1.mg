int minusAsn(int x)
{
  return x -= "hello";
}

object main {
event create
{
  std::print( minusAsn(1) );

  std::end_game();
}
}
