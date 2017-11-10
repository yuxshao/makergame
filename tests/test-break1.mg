extern void end_game();

void main () {
  int i;
  i = 0;
  while (i < 5) {
    if (i == 2) { break; } // breaks out of loop
    print(i);
    i = i + 1;
  }
  end_game();
}
