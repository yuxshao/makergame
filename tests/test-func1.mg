int add(int a, int b)
{
  return a + b;
}

object main {
event create
{
  int a;
  a = add(39, 3);
  std::print::i(a);
  std::game::end();
  return;
}
}
