app=app.out
version=-std=c++11

$(app): main.cpp
	g++ -o $(app) $(version) main.cpp

run:
	make && ./$(app)

clean:
	rm $(app)
