private namespace p {
  extern void set_window_size(int w, int h);
  extern void set_window_clear(int r, int g, int b);
  extern void set_window_title(string x);
}

void set_size(int w, int h) { p::set_window_size(w, h); }
void set_clear(int r, int g, int b) { p::set_window_clear(r, g, b); }
void set_title(string title) { p::set_window_title(title); }
