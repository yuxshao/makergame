extern void end_game();
void foo(bool i)
{
  int i; /* Should hide the formal i */

  i = 42;
  print(i + i);
}

void main()
{
  foo(true);
  end_game();
  return;
}
