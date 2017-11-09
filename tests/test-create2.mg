extern void end_game();

helper {
  // should run before main's second step
  step { printstr("helper"); }
}

aide {
  // should run before main's second step
  step { printstr("aide"); }
}

main {
  bool created;
  create { this.created = false; create aide; }
  step {
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

