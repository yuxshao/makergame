extern void end_game();

int addAsn(int x)
{
  int y;
  y = ((x += 2) = 3);
  return y;

}

void main()
{
  print( addAsn(1) );

  end_game();
  return;
}
