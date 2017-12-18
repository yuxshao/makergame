int a;
int b;

void printA()
{
  std::print::i(a);
}

void printB()
{
  std::print::i(b);
}

void incab()
{
  a = a + 1;
  b = b + 1;
}

object main {
event create
{
  a = 42;
  b = 21;
  printA();
  printB();
  incab();
  printA();
  printB();
  std::end_game();
  return;
}
}
