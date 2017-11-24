int addAsn(int x) 
{
  return x += 2;
}

object main {
event create
{
  std::print( addAsn(1) );

  std::end_game();
}
}
