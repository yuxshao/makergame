#include <SFML/Graphics.hpp>
#include <map>
#include <string>

static std::map<std::string, sf::Texture> image_map;
static sf::RenderWindow window;

static void display_window(sf::RenderWindow *window) { window->display(); }

static sf::RenderWindow *create_window(int width, int height,
                                       const char *wname) {
  return new sf::RenderWindow(sf::VideoMode(width, height), wname);
}

static void close_window(sf::RenderWindow *window) { window->close(); }

extern "C" {

sf::Sprite *load_image(const char *filename) {
  auto[name_and_image, inserted] = image_map.try_emplace(filename);
  if (!inserted)
    name_and_image->second.loadFromFile(filename);
  return new sf::Sprite(name_and_image->second);
}

void set_sprite_position(sf::Sprite *sprite, double x, double y) {
  sprite->setPosition(x, y);
}

void draw_sprite(sf::Sprite *sprite) { window.draw(*sprite); }

void end_game() { close_window(&window); }

void game_main();
}

int main() {
  window.create(sf::VideoMode(800, 600), "Hello World");
  window.setFramerateLimit(60);

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed)
        window.close();
    }
    game_main();
    window.display();
  }
  return 0;
}
