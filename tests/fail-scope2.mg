void main() {
  int x;
  x = 3;
  {
    int y;
    y = 4;
  }
  std::print(x);
  std::print(y); /* error: y not in outer scope */
}
