int i;
bool b;
int j;

object main {
event create
{
  i = 42;
  j = 10;
  std::print(i + j);
  std::end_game();
  return;
}
}
