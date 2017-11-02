extern void end_game();
bool i;

int main()
{
  int i; /* Should hide the global i */

  i = 42;
  print(i + i);
  end_game();
  return 0;
}
