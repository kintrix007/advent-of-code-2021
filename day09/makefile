app=app.out
version=-std=c11

$(app): main.c
	gcc -o $(app) $(version) main.c

run:
	make && ./$(app)

clean:
	rm $(app)
