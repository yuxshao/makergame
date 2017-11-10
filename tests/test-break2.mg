extern void end_game();

void main () {
  int i;
  for (i = 0; i < 5; i = i + 1) {
    if (i == 2) { break; } // breaks out of loop
    print(i);
  }
  end_game();
}
