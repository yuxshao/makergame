int add(int a, int b)
{
  return a + b;
}

object main {
event create
{
  std::print_float(3+3.5);
  std::print_float(3.5+3);
  std::print_float(3+3);
  int b = 4.5;
  float c = b;
  std::print_float(c);
  std::print(add(39, 3.5));
  if (3.0 == 3) {
    std::printstr("3.0 == 3\n");
  }
  else {
    std::printstr("3.0 != 3\n");
  }
  std::end_game();
}
}
