NAME=X16-TURRICAN
ASM=cl65.exe
ASM_FLAGS=-t cx16 -l $(NAME).txt -C cx16-asm.cfg

all: bin/$(NAME)

bin/$(NAME): src/$(NAME).asm
	pushd src && make all && popd

test: bin/$(NAME)
	pushd bin && ..\..\..\emulator\x16emu.exe -run -prg $(NAME) -joy1 -ram 2048 -debug && popd

clean:
	del /q bin\*.*

