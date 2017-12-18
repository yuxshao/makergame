object main {
event create
{
  for (int i = 1; i < 5 ; i = i + 1) {
    std::print::i(i);
  }
  std::print::i(i); // out of scope
  return;
}
}

