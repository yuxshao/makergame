extern void end_game();

helper {
  int i;
  create { this.i = 3; }
}

main {
  create {
    helper h;
    h = create helper;
    destroy h;
    /* destroyed objects are immediately invisible to loops */
    foreach (helper h) { printstr("still exists!"); }
    /* refs to destroyed objects still work until at least end of event */
    print(h.i);
    end_game();
  }
}
