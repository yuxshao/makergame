extern void end_game();

int minusAsn(int x)
{
  return (x -= 2) -= 2;
}

void main()
{
  print( minusAsn(0) );

  end_game();
  return;
}
