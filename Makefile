build:
	mkdir Executable
	mkdir Decoded
	mkdir Art
	swiftc Code/Bytes2Art.swift -o Executable/Bytes2Art
	swiftc Code/Art2Bytes.swift -o Executable/Art2Bytes
	make hello

clean: 
	rm -rf Executable
	rm -rf Decoded
	rm -rf Art

encode:
	./Executable/Bytes2Art Code/Bytes2Art.swift Art/Bytes2Art.png
	./Executable/Bytes2Art Code/Art2Bytes.swift Art/Art2Bytes.png

decode:
	./Executable/Art2Bytes Art/Bytes2Art.png Decoded/Bytes2Art.swift
	./Executable/Art2Bytes Art/Art2Bytes.png Decoded/Art2Bytes.swift

hello:
	@echo "Hello World!" > Hello.txt
	./Executable/Bytes2Art Hello.txt Art/Hello.png
	./Executable/Art2Bytes Art/Hello.png Decoded/Hello.txt
	@rm hello.txt

help:
	@echo "make" : to build
	@echo "make build" : to build
	@echo "make clean" : to clean
	@echo "make encode" : to create default encoded pictures
	@echo "make decode" : to create default decoded source code
	@echo "make hello" : to create default encoded and decoded "Hello World" example
	@echo "make help" : for this screen