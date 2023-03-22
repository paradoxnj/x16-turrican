NAME=X16-TURRICAN
ASM=cl65.exe
ASM_FLAGS=-t cx16 -l $(NAME).txt -C cx16-asm.cfg

all: bin/$(NAME)

bin/$(NAME): src/$(NAME).asm
	pushd src && make all && popd

test: bin/$(NAME)
	pushd bin && ..\..\..\emulator\x16emu.exe -debug -ram 2048 -joy1 -run -prg $(NAME) && popd

clean:
	del /q bin\*.*

