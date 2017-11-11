extern void end_game();

void set(main m) {
  m.x = 3;
}

object main {
  int x;
  event create {
    set(this);
    print(this.x);
    end_game();
  }
}
