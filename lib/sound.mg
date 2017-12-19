private namespace p {
  extern sound load_sound(string filename);
  extern void play_sound(sound snd, bool loop);
  extern void stop_sound(sound snd);
}

sound load(string filename) { return p::load_sound(filename); }
void play(sound s) { p::play_sound(s, false); }
void loop(sound s) { p::play_sound(s, true); }
void stop(sound s) { p::stop_sound(s); }
