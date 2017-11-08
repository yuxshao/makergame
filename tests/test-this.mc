extern void end_game();

main {
  int x;
  create { this.x = 3; }
  step {
    int x;
    x = 5;
    print(this.x);
    print(x);
    end_game();
  }
}
