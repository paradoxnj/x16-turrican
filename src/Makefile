NAME=X16-TURRICAN
ASM=cl65.exe
ASM_FLAGS=-t cx16 -l $(NAME).txt -C ..\cx16-asm.cfg

all: ../bin/$(NAME)

../bin/$(NAME): $(NAME).asm
	$(ASM) $(ASM_FLAGS) -o ..\bin\$(NAME) $(NAME).asm
