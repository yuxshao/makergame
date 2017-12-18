namespace print  = open "print.mg";
namespace spr    = open "sprite.mg";
namespace snd    = open "sound.mg";
namespace math   = open "math.mg";
namespace window = open "window.mg";
namespace key    = open "key.mg";

bool is_alive (object o) {
  foreach (object x)
    if (x == o) return true;
  return false;
}

// Game room initialization
object room {
  event create {
    foreach (object r) { if (r != this) delete r; }
    key::set_key();
  }
}

extern void end_game();
