
object helper {
  // should run before main's second step
  event step { std::print::s("helper"); }
}

object aide {
  // should run before main's second step
  event step { std::print::s("aide"); }
}

object main {
  bool created;
  event create { this.created = false; create aide; }
  event step {
    std::print::s("main");
    if (!this.created) {
      create helper;
      create helper;
      this.created = true;
    }
    else {
      create aide; // causes an 'aide' call right before the end
      std::game::end();
    }
  }
}

