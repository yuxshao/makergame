// array arguments
int sum(int x[3]) {
  int sum = 0;
  int i;
  for (i = 0; i < 3; ++i)
    sum += x[i];
  return sum;
}

object main {
  event create {
    int i[3];
    i[0] = 1;
    i[1] = 2;
    i[2] = 3;
    std::print::i(sum(i));
    std::game::end();
  }
}
