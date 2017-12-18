object aide { }

object main {
  event create {
    aide a = create aide;
    create aide;

    std::print::b(std::game::obj_alive(a));
    destroy(a);
    std::print::b(std::game::obj_alive(a));

    std::game::end();
  }
}

