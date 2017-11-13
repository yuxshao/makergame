extern void end_game();

int addAsn(int x) 
{
  return x += 2;
}

void main()
{
  print( addAsn(1) );

  end_game();
  return;
}
