

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
	@echo "for copyright info run "make copyright""
	


# Assemble the .asm file into an object file
build: $(OBJ) $(TARGET)
	@echo "building please wait"
	$(ASM) $(ASMFLAGS) -o $(OBJ) $(SRC)

# Link the object file into an executable
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJ)
	@echo "build done"

# Clean up generated files
clean:
	rm -f $(OBJ) $(TARGET)



check:
	@if [ -z "$(ASM)" ]; then \
		echo "Error: nasm is not installed."; \
		exit 1; \
	else \
		echo "nasm is installed."; \
	fi
	@if [ -z "$(LD)" ]; then \
		echo "Error: ld is not installed."; \
		exit 1; \
	else \
		echo "ld is installed."; \
	fi

copyright:
	@echo "copyright Oliver Hiivola 2025"
	@echo "some of this code made by chatgpt i wrote the makefile and chatgpt wrote the shell lol"
	@echo "stealing: its fine i dont really care just dont claim it as your own"
    
# Run the shell program
run: $(TARGET)
	./$(TARGET)

toskibidiornot:
	@echo "To skibidi or not? That is the question."

toskibidiornaur:
	@echo "Bro the command was "make toskibidiornot" not "make toskibidiornaur" bruuh"
	@echo ""make skibidied". run that broo" 

skibidied:
	@echo "Well well well, you skibidied."

funny:
	@echo "the fun commands are "make toskibidiornot" and "make skibidied""