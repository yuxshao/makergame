private namespace p {
  extern int rand();
  extern int rand_max();
}

int irandom(int x) { return p::rand() % x; }
float frandom() {
  float x = p::rand();
  float y = p::rand_max();
  return x / y;
}

// Trig, straight from cmath, linked via -lm
extern float sin(float x);
extern float cos(float x);
extern float tan(float x);
extern float asin(float x);
extern float acos(float x);
extern float atan(float x);
extern float atan2(float y, float x);
extern float sqrt(float x);
