int a;
int b;

void printA()
{
  std::print(a);
}

void printB()
{
  std::print(b);
}

void incab()
{
  a = a + 1;
  b = b + 1;
}

void main()
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
