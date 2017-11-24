
void main () {
  int x;
  x = 3;
  std::print (x);

  int y;
  y = 4;
  std::print (y);

  if (x == 3) {
    std::print (x);
    int x; // OK: can redeclare in different block
    x = 5;
    std::print (x);
  }
  std::print (x);
  std::end_game();
}
