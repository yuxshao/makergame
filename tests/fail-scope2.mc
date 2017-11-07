extern void end_game();

void main() {
  int x;
  x = 3;
  {
    int y;
    y = 4;
  }
  print(x);
  print(y); /* error: y not in outer scope */
  end_game();
}
