object main {
event create {
  float f1;
  f1 = 3.5;
  float f2;
  f2 = 2.5;
  float sum;
  sum = f1 + f2;
  std::print::f(sum);
  std::end_game();
}
}
