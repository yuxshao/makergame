void foo(bool i)
{
  int i; /* Should hide the formal i */

  i = 42;
  std::print(i + i);
}

object main {
event create
{
  foo(true);
  std::end_game();
  return;
}
}
