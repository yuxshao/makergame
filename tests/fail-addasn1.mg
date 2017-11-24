int addAsn(int x)
{
  return x += "hello";
}

object main {
  event create {
    std::print( addAsn(1) );
    std::end_game();
  }
}
