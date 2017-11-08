extern void end_game();

void set(main m) {
  m.x = 3;
}

main {
  int x;
  create {
    set(this);
    print(this.x);
    end_game();
  }
}
