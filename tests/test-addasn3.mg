int addAsn(int x)
{
  int y;
  y = ((x += 2) = 3);
  return y;
}

object main {
event create
{
  std::print::i( addAsn(1) );

  std::game::end();
}
}
