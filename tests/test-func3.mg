void printem(int a, int b, int c, int d)
{
  std::print(a);
  std::print(b);
  std::print(c);
  std::print(d);
}

object main {
event create
{
  printem(42,17,192,8);
  std::end_game();
  return;
}
}
