void foo(int a)
{
  std::print::i(a + 3);
}

object main {
event create
{
  foo(40);
  std::game::end();
  return;
}
}
