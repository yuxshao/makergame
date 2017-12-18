
int compute() {
  int i;  

  i = 15;
  std::print::i(i);
  return i;

  i = 32; /* code after a return is ok */
  std::print::i(i);
}

object main {
event create
{
  compute();
  std::end_game();
}
}
