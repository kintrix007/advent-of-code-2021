app=app.out
main=main.nim

app.out: main.nim
	nim c -o:$(app) $(main)

run:
	nim r $(main)

clean:
	rm $(app)
