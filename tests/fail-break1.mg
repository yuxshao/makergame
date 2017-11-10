extern void end_game();

void main () {
  break; // error: cannot break in outermost block
  end_game();
}
