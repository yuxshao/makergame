int add(int a, int b)
{
  return a + b;
}

object main {
event create
{
  std::print::f(3+3.5);
  std::print::f(3.5+3);
  std::print::f(3+3);
  int b = 4.5;
  float c = b;
  std::print::f(c);
  std::print::i(add(39, 3.5));
  if (3.0 == 3) {
    std::print::s("3.0 == 3\n");
  }
  else {
    std::print::s("3.0 != 3\n");
  }
  std::game::end();
}
}
