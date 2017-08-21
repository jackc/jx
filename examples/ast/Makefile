P=ast
OBJECTS=ast.o
CFLAGS = -g -Wall -Werror -O3 -I.
LDLIBS=
CXX=g++

$(P): $(OBJECTS)
	$(CXX) $(CPPFLAGS) $(OBJECTS) -o $@ $(LDFLAGS) $(LDLIBS)

ast.cpp: ast.rb
	ruby -I../../lib ast.rb > ast.cpp

