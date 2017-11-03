/* Bug noticed by Pin-Chin Huang */
extern void end_game();

int fun(int x, int y)
{
  return 0;
}

void main()
{
  int i;
  i = 1;

  fun(i = 2, i = i+1);

  print(i);
  end_game();
  return;
}

