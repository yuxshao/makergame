
object helper {
  int y;
  event create { this.y = 3; }
  event destroy { std::print(this.y); std::end_game(); }
}

object main {
  int y;
  helper h;
  event create { this.h = create helper; }
  event step {
    destroy this.h;
  }
}
