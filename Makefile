build:
	mkdir Executable
	mkdir Decoded
	mkdir Art
	swiftc Code/Bytes2Art.swift -o Executable/Bytes2Art
	swiftc Code/Art2Bytes.swift -o Executable/Art2Bytes

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
	echo "Hello World!" > hello.txt
	./Executable/Bytes2Art hello.txt Art/hello.png
	./Executable/Art2Bytes Art/hello.png Decoded/hello.txt
	rm hello.txt