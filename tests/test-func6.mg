void foo() {}

int bar(int a, bool b, int c) { return a + c; }

object main {
event create
{
  std::print(bar(17, false, 25));
  std::end_game();
  return;
}
}
