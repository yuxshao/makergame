extern void end_game();

int compute() {
  int i;  

  i = 15;
  print(i);
  return i;

  i = 32; /* code after a return is ok */
  print(i);
}

void main()
{
  compute();
  end_game();
}
