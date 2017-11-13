extern void end_game();

int addAsn(int x)
{
  return (x += 2) += 2;
}

void main()
{
  print( addAsn(0) );

  end_game();
  return;
}
