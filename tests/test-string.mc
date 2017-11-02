extern void end_game();
int main () {
  string c;
  c = "hello world";
  printstr(c);
  printstr("goodbye world");
  printstr("this is \"right\"");
  printstr("Either\\or is okay");
  printstr("multiple\nlines");
  end_game();
  return 0;
}
