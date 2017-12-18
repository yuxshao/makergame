
int minusAsn(int x)
{
  return x -= 2;
}

object main {
event create
{
  std::print::i( minusAsn(2) );

  std::game::end();
  return;
}
}
