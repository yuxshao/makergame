int foo(int a)
{
  return a;
}

object main {
event create
{
  int a;
  a = 42;
  a = a + 5;
  std::print::i(a);
  std::end_game();
}
}
