bool a;
object main {
  int a;
  event create {
    a = 5;
    std::print::i(a);
    std::end_game();
  }
}
