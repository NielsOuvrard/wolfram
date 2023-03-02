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
	@echo "#!/bin/sh" > $(TARGET)
	@echo "arrVar=()" >> $(TARGET)
	@echo 'for i in "$$@"; do' >> $(TARGET)
	@echo '    arrVar+=("$$i")' >> $(TARGET)
	@echo 'done' >> $(TARGET)
	@find . | grep "bin/Wolframe-exe" >> $(TARGET)
	@truncate -s-1 $(TARGET)
	@echo " \"\$${arrVar[@]}\"" >> $(TARGET)
	@chmod +x $(TARGET)

clean:
	@rm -f $(TARGET)

fclean: clean
	@rm -rf .stack-work

re: fclean all

.PHONY: all clean fclean re

# @echo "stack exec -- Wolframe-exe \"\$${arrVar[@]}\"" >> $(TARGET)