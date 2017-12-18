
int minusAsn(int x)
{
  return (x -= 2) -= 2;
}

object main {
event create
{
  std::print::i( minusAsn(0) );

  std::end_game();
  return;
}
}
