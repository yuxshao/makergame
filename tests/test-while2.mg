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

object main {
event create
{
  std::print(foo(7));
  std::end_game();
  return;
}
}
