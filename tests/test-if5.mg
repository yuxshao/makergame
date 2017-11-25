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
 std::print(cond(true));
 std::print(cond(false));
 std::end_game();
 return;
}
}
