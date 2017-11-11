extern void end_game();

object helper {
  int i;
  event create { this.i = 3; }
}

object main {
  event create {
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
