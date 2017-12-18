int foo(int a, bool b)
{
  int c;
  bool d;

  c = a;

  return c + 10;
}

object main {
event create {
 std::print::i(foo(37, false));
 std::end_game();
 return;
}
}
