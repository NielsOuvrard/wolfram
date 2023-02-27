##
## EPITECH PROJECT, 2022
## Makefile
## File description:
## Makefile
##

TARGET := Wolfram

all:
	@stack build
	@touch $(TARGET)
	@find . | grep "bin/Wolframe-exe" > $(TARGET)
	@chmod +x $(TARGET)

clean:
	@rm -f $(TARGET)

fclean: clean
	@rm -rf .stack-work

re: fclean all

.PHONY: all clean fclean re