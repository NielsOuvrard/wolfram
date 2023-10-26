#include <vector>
#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
#include <SFML/System.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>

typedef struct wolfram
{
    int rule;
    int lines;
    int window;
    int start;
    int move;
    int size_pixel;
} wolfram_t;

bool event_handling(sf::RenderWindow &window, wolfram_t &wolfram)
{
    sf::Event event;
    bool change = false;
    while (window.pollEvent(event))
    {
        if (event.type == sf::Event::Closed)
            window.close();
        if (event.type == sf::Event::KeyPressed)
            change = true;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::A)
            wolfram.lines++;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Z)
            wolfram.lines--;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::E)
            wolfram.window++;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::R)
            wolfram.window--;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::T)
            wolfram.start++;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Y)
            wolfram.start--;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::U)
            wolfram.move++;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::I)
            wolfram.move--;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::O)
            wolfram.rule++;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::P)
            wolfram.rule--;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Up)
            wolfram.size_pixel++;
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Down)
            wolfram.size_pixel--;
    }
    return change;
}

// adapt screen size to pixel size

#define SIZE_PIXEL 10

char **get_lines(FILE *file)
{
    char **lines = NULL;
    char buffer[1024];
    int i = 0;

    while (fgets(buffer, sizeof(buffer), file) != NULL)
    {
        lines = (char **)realloc(lines, sizeof(char *) * (i + 1));
        lines[i] = strdup(buffer);
        i++;
    }
    lines = (char **)realloc(lines, sizeof(char *) * (i + 1));
    lines[i] = NULL;
    return lines;
}

int main()
{
    // define a 120x50 rectangle
    sf::RectangleShape rectangle(sf::Vector2f(120.f, 50.f));

    wolfram_t wolfram;
    wolfram.rule = 90;
    wolfram.lines = 60;
    wolfram.window = 80;
    wolfram.start = 0;
    wolfram.move = 0;
    wolfram.size_pixel = SIZE_PIXEL;

    FILE *file = popen("./wolfram --rule 90 --lines 60", "r");
    if (!file)
        return 1;
    char **lines = get_lines(file);
    pclose(file);

    sf::RenderWindow window(sf::VideoMode(1280, 720), "Monitor");
    while (window.isOpen())
    {
        window.clear();
        if (event_handling(window, wolfram))
        {
            char *command = NULL;
            asprintf(&command, "./wolfram --rule %d --lines %d --window %d --start %d --move %d", wolfram.rule, wolfram.lines, wolfram.window, wolfram.start, wolfram.move);
            file = popen(command, "r");
            if (!file)
                return 1;
            lines = get_lines(file);
            pclose(file);
            free(command);
            rectangle.setSize(sf::Vector2f(wolfram.size_pixel, wolfram.size_pixel));
        }

        for (int i = 0; lines[i]; i++)
        {
            for (int j = 0; lines[i][j] != '\0'; j++)
            {
                if (lines[i][j] == '*')
                {
                    rectangle.setFillColor(sf::Color::White);
                }
                else
                {
                    rectangle.setFillColor(sf::Color::Black);
                }
                rectangle.setPosition(sf::Vector2f(j * wolfram.size_pixel, i * wolfram.size_pixel));
                window.draw(rectangle);
            }
        }
        window.display();
    }
    return 0;
}
