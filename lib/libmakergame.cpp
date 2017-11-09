#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <map>
#include <string>
#include <iostream>
#include <cstdlib>

static std::map<std::string, sf::Texture> image_map;
static std::map<std::string, sf::SoundBuffer> sound_map;
static sf::RenderWindow window;

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

sf::Sound *load_sound(const char *filename) {
  if (!sound_map.count(filename) && !sound_map[filename].loadFromFile(filename))
    std::cerr << "unable to load sound " << filename << "\n";
  return new sf::Sound(sound_map[filename]);
}

void play_sound(sf::Sound *sound) { play_sound(sound, false); }
void loop_sound(sf::Sound *sound) { play_sound(sound, true); }

sf::Sprite *load_image(const char *filename) {
  if (!image_map.count(filename) && !image_map[filename].loadFromFile(filename))
    std::cerr << "unable to load image " << filename << "\n";
  return new sf::Sprite(image_map[filename]);
}

void set_sprite_position(sf::Sprite *sprite, double x, double y) {
  sprite->setPosition(x, y);
}

void draw_sprite(sf::Sprite *sprite) { window.draw(*sprite); }

void end_game() { close_window(&window); game_ended = true; }

// TODO find a better place for libs
int irandom(int x) { return rand() % x; }

// TODO remove
double to_dbl(int x) { return (double)x; }

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
  global_create();
  if (game_ended) return 0;

  window.create(sf::VideoMode(800, 600), "Hello World");
  window.setFramerateLimit(60);

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed)
        window.close();
    }
    global_step();
    window.clear();
    global_draw();
    window.display();
  }

  sound_map.empty();
  image_map.empty();

  return 0;
}
