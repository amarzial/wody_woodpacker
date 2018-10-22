SRC = ./src/<source_file>

INCLUDE_DIR = ./include

OBJ=$(addprefix obj/,$(notdir $(SRC:.c=.o)))
DEP=$(addprefix .d/,$(notdir $(SRC:.c=.d)))

CC=gcc
CFLAGS=-Wall -Werror -Wextra -O2
COMPILE.c=$(CC) $(CFLAGS) -c
OUTPUT_OPTION= -MMD -MP -MF $(patsubst %.o,.d/%.d,$(notdir $@)) -o $@

obj/%.o: src/%.c
	@mkdir -p obj/
	@mkdir -p .d/
	$(COMPILE.c) $(OUTPUT_OPTION) $< -I$(INCLUDE_DIR)

NAME=woody_woodpacker

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJ)
	$(LINK.o) -o $@ $(OBJ)

clean:
	rm -rf .d/
	rm -rf obj/

fclean: clean
	rm -f $(NAME)

re: fclean all

-include $(DEP)
