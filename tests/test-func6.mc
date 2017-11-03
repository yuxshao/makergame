extern void end_game();
void foo() {}

int bar(int a, bool b, int c) { return a + c; }

void main()
{
  print(bar(17, false, 25));
  end_game();
  return;
}
