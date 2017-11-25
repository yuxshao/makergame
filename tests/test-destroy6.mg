
int i;

object main {
  event create {
    if (i < 5) {
      destroy this;
      i += 1;
      std::print(i);
      create main;
    }
    else std::end_game();
  }
}
