#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <map>
#include <string>
#include <iostream>
#include <cstdlib>

static std::map<std::string, sf::Texture> image_map;
static std::map<std::string, sf::Sprite> sprite_map;
static std::map<std::string, sf::SoundBuffer> sound_map;
static sf::RenderWindow window;
static sf::Color clear_color = sf::Color(255, 255, 255);

static void display_window(sf::RenderWindow *window) { window->display(); }

static sf::RenderWindow *create_window(int width, int height,
                                       const char *wname) {
  return new sf::RenderWindow(sf::VideoMode(width, height), wname);
}

static void close_window(sf::RenderWindow *window) {
  if (window->isOpen()) window->close();
}

static void play_sound(sf::Sound *sound, bool loop) {
  sound->stop();
  sound->setLoop(loop);
  sound->play();
}

static bool game_ended = false;

extern "C" {

// built-in print functions
void print(int x) { printf("%d\n", x); }
void printb(bool x) { if (x) printf("true\n"); else printf("false\n"); }
void print_float(double x) { printf("%f\n", x); }
void printstr(char *x) { printf("%s\n", x); }

sf::Sound *load_sound(const char *filename) {
  if (!sound_map.count(filename) && !sound_map[filename].loadFromFile(filename))
    std::cerr << "unable to load sound " << filename << "\n";
  return new sf::Sound(sound_map[filename]);
}

void set_window_size(int w, int h) {
  window.setSize(sf::Vector2u(w, h));
  window.setView(sf::View(sf::FloatRect(0, 0, w, h)));
}
void set_window_clear(int r, int g, int b) { clear_color = sf::Color(r, g, b); }
void set_window_title(char *x) { window.setTitle(x); }

void play_sound(sf::Sound *sound) { play_sound(sound, false); }
void loop_sound(sf::Sound *sound) { play_sound(sound, true); }

sf::Sprite *load_image(const char *filename) {
  if (!image_map.count(filename)) {
    if (!image_map[filename].loadFromFile(filename))
      std::cerr << "unable to load image " << filename << "\n";
    sprite_map[filename] = sf::Sprite(image_map[filename]);
  }
  return &sprite_map[filename];
}

int sprite_width(sf::Sprite *sprite) { sprite->getTextureRect().width; }
int sprite_height(sf::Sprite *sprite) { sprite->getTextureRect().height; }

void draw_sprite(sf::Sprite *sprite, double x, double y) {
  sprite->setPosition(x, y);
  window.draw(*sprite);
}

void end_game() { close_window(&window); game_ended = true; }

// TODO find a better place for libs
int irandom(int x) { return rand() % x; }

// TODO find better way. enums in our language? or namespaces?
bool key_pressed(int code) {
  return sf::Keyboard::isKeyPressed(sf::Keyboard::Key(code));
}

void global_create();
void global_step();
void global_draw();
}

int main() {
  srand(time(NULL));

  window.create(sf::VideoMode(800, 600), "MakerGame Game");
  window.setFramerateLimit(60);

  global_create();

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed)
        window.close();
    }
    global_step();
    window.clear(clear_color);
    global_draw();
    window.display();
  }

  sound_map.empty();
  image_map.empty();

  return 0;
}
