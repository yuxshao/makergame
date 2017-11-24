void foo(int a)
{
  std::print(a + 3);
}

object main {
event create
{
  foo(40);
  std::end_game();
  return;
}
}
