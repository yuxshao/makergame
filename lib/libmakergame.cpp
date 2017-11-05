#include <SFML/Graphics.hpp>
#include <map>
#include <string>
#include <iostream>

static std::map<std::string, sf::Texture> image_map;
static sf::RenderWindow window;

static void display_window(sf::RenderWindow *window) { window->display(); }

static sf::RenderWindow *create_window(int width, int height,
                                       const char *wname) {
  return new sf::RenderWindow(sf::VideoMode(width, height), wname);
}

static void close_window(sf::RenderWindow *window) {
  if (window->isOpen()) window->close();
}

static bool game_ended = false;

extern "C" {

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

void main_create();
void main_step();
void main_destroy();
void main_draw();
}

int main() {
  main_create();
  if (game_ended) return 0;

  window.create(sf::VideoMode(800, 600), "Hello World");
  window.setFramerateLimit(60);

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed)
        window.close();
    }
    main_step();
    window.clear();
    main_draw();
    window.display();
  }

  main_destroy();
  return 0;
}
