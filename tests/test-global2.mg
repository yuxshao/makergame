bool i;

void main()
{
  int i; /* Should hide the global i */

  i = 42;
  std::print(i + i);
  std::end_game();
  return;
}
