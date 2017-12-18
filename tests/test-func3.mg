void printem(int a, int b, int c, int d)
{
  std::print::i(a);
  std::print::i(b);
  std::print::i(c);
  std::print::i(d);
}

object main {
event create
{
  printem(42,17,192,8);
  std::game::end();
  return;
}
}
