void main()
{
  int x;
  x = 0;
  std::print((x += 2) += 2);
  std::print(x);
  std::end_game();
}
