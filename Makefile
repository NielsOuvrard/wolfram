##
## EPITECH PROJECT, 2022
## Makefile
## File description:
## Makefile
##

BINARY_PATH :=	$(shell stack path --local-install-root)
NAME = wolfram

# if macos
ifeq ($(shell uname), Darwin)
	CSFML_FLAGS = -g -g3 -std=c++20 -lncurses -I/opt/homebrew/Cellar/sfml/2.6.0/include -L/opt/homebrew/Cellar/sfml/2.6.0/lib -lsfml-window -lsfml-graphics -lsfml-system
else
	CSFML_FLAGS = -g -g3 -std=c++20 -lncurses -lsfml-window -lsfml-graphics -lsfml-system
endif

all:
		stack build
		cp $(BINARY_PATH)/bin/$(NAME)-exe ./$(NAME)

gui:
	@ export LIBRARY_PATH=/opt/homebrew/Cellar/sfml/2.6.0/lib/
	@ export C_INCLUDE_PATH=/opt/homebrew/include
	@ g++ -o wolfram-gui gui.cpp $(CSFML_MAC) -I./include

clean:
		stack clean

fclean: clean
		rm -f $(NAME)
		rm -f wolfram-gui

re: fclean all

.PHONY: all clean fclean re