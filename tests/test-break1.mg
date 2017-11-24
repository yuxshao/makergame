void main () {
  int i;
  i = 0;
  while (i < 5) {
    if (i == 2) { break; } // breaks out of loop
    std::print(i);
    i = i + 1;
  }
  std::end_game();
}
