bool i;

object main {
event create
{
  int i; /* Should hide the global i */

  i = 42;
  std::print::i(i + i);
  std::end_game();
  return;
}
}
