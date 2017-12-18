namespace key = open "key.mg";
namespace spr = open "sprite.mg";
namespace snd = open "sound.mg";

private namespace p {
  extern void end_game();
}

bool obj_alive (object o) {
  foreach (object x)
    if (x == o) return true;
  return false;
}

// objects that remove all other objects
// TODO: Should remove at start of step. but awkward syntax then...
//       To get this right, need real custom virtual functions
object room {
  event create {
    foreach (object r) { if (r != this) delete r; }
    key::set_key();
  }
}

object obj {
  sprite spr;
  // TODO: syntactic sugar for vec2i, vec2f. maybe vec3 too
  // basically let x and y be [0] and [1] respectively for float[2]
  // rects could be float[4], w and h the next [2] and [3]
  float x; float y;
  float hspeed; float vspeed;
  float origin_x; float origin_y;
  float hitbox_offx; float hitbox_offy; float hitbox_w; float hitbox_h;

  // center the hitbox on the origin with width sw, height sh
  void center_hitbox_abs(float sw, float sh) {
    set_hitbox(-sw/2, -sh/2, sw, sh);
  }

  // centre the hitbox on the origin, and set its width and height to
  // xprop * sprite_width, yprop * sprite_height
  void center_hitbox_prop(float xprop, float yprop) {
    float sw = xprop * spr::width(spr);
    float sh = yprop * spr::height(spr);
    center_hitbox_abs(sw, sh);
  }

  void set_hitbox(float x, float y, float w, float h) {
    hitbox_offx = x; hitbox_offy = y;
    hitbox_w = w; hitbox_h = h;
  }

  event create(float x, float y, string sprite_name) {
    this.x = x; this.y = y;
    spr = spr::load(sprite_name);
    origin_x = spr::width(spr) * 0.5;
    origin_y = spr::height(spr) * 0.5;
    center_hitbox_abs(0, 0);
  }
  event draw {
    x += hspeed; y += vspeed;
    spr::render(spr, x-origin_x, y-origin_y);
  }
}

bool colliding(obj a, obj b) {
  float al = a.x + a.hitbox_offx;
  float au = a.y + a.hitbox_offy;
  float ar = a.x + a.hitbox_offx + a.hitbox_w;
  float ad = a.y + a.hitbox_offy + a.hitbox_h;
  float bl = b.x + b.hitbox_offx;
  float bu = b.y + b.hitbox_offy;
  float br = b.x + b.hitbox_offx + b.hitbox_w;
  float bd = b.y + b.hitbox_offy + b.hitbox_h;
  return (al < br && ar > bl && au < bd && ad > bu);
}

void end() { p::end_game(); }
