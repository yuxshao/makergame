extern void end_game();
int foo(int a)
{
  return a;
}

void main()
{
  int a;
  a = 42;
  a = a + 5;
  print(a);
  end_game();
  return;
}