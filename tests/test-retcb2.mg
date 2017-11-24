
int compute() {
  int i;  

  i = 15;
  std::print(i);
  return i;

  i = 32; /* code after a return is ok */
  std::print(i);
}

void main()
{
  compute();
  std::end_game();
}
