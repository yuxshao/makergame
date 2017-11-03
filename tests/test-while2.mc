extern void end_game();
int foo(int a)
{
  int j;
  j = 0;
  while (a > 0) {
    j = j + 2;
    a = a - 1;
  }
  return j;
}

void main()
{
  print(foo(7));
  end_game();
  return;
}
