// array returns
int make_ten_of[10](int x) {
  int ret[10];
  int i;
  for (i = 0; i < 10; ++i)
    ret[i] = x;
  return ret;
}

object main {
  event create {
    int i = 3;
    int j[10] = make_ten_of(5);
    std::print::i(j[i]);
    std::game::end();
  }
}
