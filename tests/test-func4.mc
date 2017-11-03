extern void end_game();
int add(int a, int b)
{
  int c;
  c = a + b;
  return c;
}

void main()
{
  int d;
  d = add(52, 10);
  print(d);
  end_game();
  return;
}
