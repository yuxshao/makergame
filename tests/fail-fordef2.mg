object main {
event create
{
  for (int i = 1; i < 5 ; i = i + 1) {
    std::print(i);
  }
  std::print(i); // out of scope
  return;
}
}

