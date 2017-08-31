P=hello
OBJECTS=hello.o
CPPFLAGS = -std=c++17 -g -Wall -Werror -O3 -I.
LDLIBS=
CXX=g++

$(P): $(OBJECTS)
	$(CXX) $(CPPFLAGS) $(OBJECTS) -o $@ $(LDFLAGS) $(LDLIBS)

hello.cpp: hello.jx
	jxc hello.jx

.PHONY: clean
clean:
	rm -f $(P) $(OBJECTS) *.cpp
