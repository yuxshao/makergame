int minusAsn(int x)
{
  return x -= "hello";
}

object main {
event create
{
  std::print::i( minusAsn(1) );

  std::end_game();
}
}
