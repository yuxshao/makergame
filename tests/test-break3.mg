extern void end_game();

helper { }
main {
  create {
    create helper;
    create helper;
    create helper;
    create helper;
    int i;
    i = 0;
    foreach (helper h) {
      if (i == 2) break;
      print(i);
      i = i + 1;
    }
    end_game();
  }
}
