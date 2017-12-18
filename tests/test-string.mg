object main {
event create {
  string c;
  c = "hello world";
  std::print::s(c);
  std::print::s("goodbye world");
  std::print::s("this is \"right\"");
  std::print::s("Either\\or is okay");
  std::print::s("multiple\nlines");
  std::end_game();
  return;
}
}
