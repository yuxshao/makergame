int cond(bool b)
{
  int x;
  if (b)
    x = 42;
  else
    x = 17;
  return x;
}

object main {
event create
{
 std::print::i(cond(true));
 std::print::i(cond(false));
 std::game::end();
 return;
}
}
