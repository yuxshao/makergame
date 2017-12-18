/* Bug noticed by Pin-Chin Huang */

int fun(int x, int y)
{
  return 0;
}

object main {
event create
{
  int i;
  i = 1;

  fun(i = 2, i = i+1);

  std::print::i(i);
  std::game::end();
  return;
}
}

