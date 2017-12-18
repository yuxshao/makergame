object main {
  event create
  {
    int x = 5;
    x -= 2.5; // turns to 5 - 2 = 3

    float y = 10.0;
    y -= 3; // turns to 10.0 - 3.0 = 7.0
    std::print::i(x);
    std::print::f(y);
    std::end_game();
  }
}
