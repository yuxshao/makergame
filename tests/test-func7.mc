extern void end_game();
int a;

void foo(int c)
{
  a = c + 42;
}

int main()
{
  foo(73);
  print(a);
  end_game();
  return 0;
}
