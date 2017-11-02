extern void end_game();
int a;
int b;

void printA()
{
  print(a);
}

void printB()
{
  print(b);
}

void incab()
{
  a = a + 1;
  b = b + 1;
}

int main()
{
  a = 42;
  b = 21;
  printA();
  printB();
  incab();
  printA();
  printB();
  end_game();
  return 0;
}
