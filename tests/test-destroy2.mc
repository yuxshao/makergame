extern void end_game();

helper {
  create { destroy this; }
}

main {
  create {
    create helper;
    int i;
    i = 0; /* count # helpers */
    foreach (helper h) { i = i + 1; }
    print(i);
    end_game();
  }
}
