all: calculator

yc3743.calc.tab.c yc3743.calc.tab.h: yc3743.calc.y
	bison -d yc3743.calc.y

lex.yy.c: yc3743.calc.l yc3743.calc.tab.h
	flex yc3743.calc.l

calculator: yc3743.calc.tab.c lex.yy.c
	g++ -o calculator lex.yy.c yc3743.calc.tab.c

clean: 
	rm yc3743.calc.tab.c yc3743.calc.tab.h lex.yy.c calculator