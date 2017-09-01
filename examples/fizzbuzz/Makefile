P=fizzbuzz
OBJECTS=fizzbuzz.o
CPPFLAGS = -std=c++17 -g -Wall -Werror -O3 -I.
LDLIBS=
CXX=g++

$(P): $(OBJECTS)
	$(CXX) $(CPPFLAGS) $(OBJECTS) -o $@ $(LDFLAGS) $(LDLIBS)

fizzbuzz.cpp: fizzbuzz.jx
	jxc fizzbuzz.jx

.PHONY: clean
clean:
	rm -f $(P) $(OBJECTS) *.cpp
