P=hello
OBJECTS=hello.o
CFLAGS = -g -Wall -Werror -O3 -I.
LDLIBS=
CXX=g++

$(P): $(OBJECTS)
	$(CXX) $(CPPFLAGS) $(OBJECTS) -o $@ $(LDFLAGS) $(LDLIBS)

hello.cpp: hello.jx
	jxc hello.jx

