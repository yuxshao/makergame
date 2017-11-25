int a;

void foo(int c)
{
  a = c + 42;
}

object main {
event create
{
  foo(73);
  std::print(a);
  std::end_game();
  return;
}
}
