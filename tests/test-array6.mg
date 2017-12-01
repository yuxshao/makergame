// multidimensional arrays
object main {
  event create {
    int x[3][3] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
    int i; int j;
    for (i = 0; i < 3; ++i)
      for (j = 0; j < 3; ++j)
        std::print(x[i][j]);
    std::end_game();
  }
}
