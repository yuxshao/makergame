int addAsn(int x) 
{
  return x += 2;
}

object main {
event create
{
  std::print::i( addAsn(1) );

  std::game::end();
}
}
