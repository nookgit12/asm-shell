# Variables
ASM = nasm
LD = ld
ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386
TARGET = shell
SRC = shell.asm
OBJ = $(SRC:.asm=.o)

# Default target
all:
	@echo "brotha you need to run make build to build the shell"
	@echo "for copyright info run 'make copyright'"

# Assemble the .asm file into an object file and link
build: $(OBJ) $(TARGET)
	@echo "building please wait"
	$(ASM) $(ASMFLAGS) -o $(OBJ) $(SRC)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJ)
	@echo "build done"

# Clean up generated files
clean:
	rm -f $(OBJ) $(TARGET)

# Check if nasm and ld are installed
check:
	@if ! command -v $(ASM) &> /dev/null; then \
		echo "Error: nasm is not installed."; \
		exit 1; \
	else \
		echo "nasm is installed."; \
	fi
	@if ! command -v $(LD) &> /dev/null; then \
		echo "Error: ld is not installed."; \
		exit 1; \
	else \
		echo "ld is installed."; \
	fi

# Display copyright info
copyright:
	@echo "Copyright Oliver Hiivola 2025"
	@echo "Feel free to use or modify, but please give credit."

# Run the shell program
run: $(TARGET)
	./$(TARGET)

# Fun commands
toskibidiornot:
	@echo "To skibidi or not? That is the question."

toskibidiornaur:
	@echo "Bro the command was 'make toskibidiornot' not 'make toskibidiornaur' bruuh"
	@echo "'make skibidied' to execute that command."

skibidied:
	@echo "Well well well, you skibidied."

funny:
	@echo "The fun commands are 'make toskibidiornot' and 'make skibidied'."
	@echo "You can also run 'make toskibidiornaur' for a funny message."