extern void end_game();

object aide { event create { printstr("aide"); } }

object main {
  bool created;
  event create {
    int i;
    create aide;
    i = 1;
    foreach(aide h)
      if (i < 5) { create aide; i = i + 1; }
    /* should create 5 aides, since new one should also be iterated over */
    end_game();
  }
}

