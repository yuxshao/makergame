// multidimensional arrays
// non-const expressions in literals
object main {
  event create {
    int y = 3;
    int x[3][3] = [[1, 2, y], [4, 5, 6], [7, 8, 9]];
    int i; int j;
    for (i = 0; i < 3; ++i)
      for (j = 0; j < 3; ++j)
        std::print::i(x[i][j]);
    std::game::end();
  }
}
