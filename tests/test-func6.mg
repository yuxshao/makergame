void foo() {}

int bar(int a, bool b, int c) { return a + c; }

object main {
event create
{
  std::print::i(bar(17, false, 25));
  std::game::end();
  return;
}
}
