object aide { }

object main {
  event create {
    aide a = create aide;
    create aide;

    std::print::b(std::is_alive(a));
    destroy(a);
    std::print::b(std::is_alive(a));

    std::end_game();
  }
}

