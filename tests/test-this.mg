
object main {
  int x;
  event create { this.x = 3; }
  event step {
    int x;
    x = 5;
    std::print(this.x);
    std::print(x);
    std::end_game();
  }
}
