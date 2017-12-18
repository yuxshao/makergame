void foo(bool i)
{
  int i; /* Should hide the formal i */

  i = 42;
  std::print::i(i + i);
}

object main {
event create
{
  foo(true);
  std::game::end();
  return;
}
}
