int a;

void foo(int c)
{
  a = c + 42;
}

void main()
{
  foo(73);
  std::print(a);
  std::end_game();
  return;
}
