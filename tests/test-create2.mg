extern void end_game();

object helper {
  // should run before main's second step
  event step { printstr("helper"); }
}

object aide {
  // should run before main's second step
  event step { printstr("aide"); }
}

object main {
  bool created;
  event create { this.created = false; create aide; }
  event step {
    printstr("main");
    if (!this.created) {
      create helper;
      create helper;
      this.created = true;
    }
    else {
      create aide; // causes an 'aide' call right before the end
      end_game();
    }
  }
}

