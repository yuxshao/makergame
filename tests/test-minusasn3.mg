
int minusAsn(int x)
{
  int y;
  y = ((x -= 2) = 3);
  return y;

}

object main {
event create
{
  std::print::i( minusAsn(1) );

  std::end_game();
  return;
}
}
