extern void end_game();
int foo(int a, bool b)
{
  int c;
  bool d;

  c = a;

  return c + 10;
}

void main() {
 print(foo(37, false));
 end_game();
 return;
}
