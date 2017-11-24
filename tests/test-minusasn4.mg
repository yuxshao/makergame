
int minusAsn(int x)
{
  return (x -= 2) -= 2;
}

void main()
{
  std::print( minusAsn(0) );

  std::end_game();
  return;
}
