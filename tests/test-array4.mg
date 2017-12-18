// multidimensional arrays
object main {
  event create {
    int x[5][2] = [[00, 01], [10, 11], [20, 21], [30, 31], [40, 41]];
    std::print::i(x[3][1]);
    std::game::end();
  }
}
