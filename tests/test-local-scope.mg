bool a;
object main {
  int a;
  event create {
    a = 5;
    std::print(a);
    std::end_game();
  }
}
