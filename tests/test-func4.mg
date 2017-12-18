int add(int a, int b)
{
  int c;
  c = a + b;
  return c;
}

object main {
event create
{
  int d;
  d = add(52, 10);
  std::print::i(d);
  std::end_game();
  return;
}
}
