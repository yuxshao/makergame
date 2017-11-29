// multidimensional arrays
object main {
  event create {
    int x[3][3];
    int i; int j;
    for (i = 0; i < 3; ++i)
      for (j = 0; j < 3; ++j)
        x[i][j] = i + j;
    std::print(x[1][2]);
    std::end_game();
  }
}
