extern void end_game();
void main()
{
  int a;
  a = 42;
  print(++a);
  ++a = 3;
  print(a);
  print(--a);
  print(--a + 5);
  end_game();
}
