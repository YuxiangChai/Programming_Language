%{
#include <iostream>
#include <iomanip> 
#include <string>
#include <map>
#include "util.h"
#include <math.h>

using namespace std;

int yylex(); // A function that is to be generated and provided by flex,
             // which returns a next token when called repeatedly.
int yyerror(const char *p) { std::cerr << "error: " << p << std::endl; return 0; };

map<string, double> dict;

double assign(char* v, double n)
{
    string str(v);
    dict[str] = n;
    return n;
}

double get(char* v)
{
    string str(v);
    return dict[str];
}
%}

%union {
    double val;
    char* st;
    /* You may include additional fields as you want. */
    /* char op; */
};

%start program

%token L_BRACKET R_BRACKET
%token EOL DIV MUL ADD SUB POW MOD PI
%token SQRT ABS FLOOR CEIL LOG2 LOG10 FACTORIAL
%token COS SIN TAN GBP_TO_USD USD_TO_GBP GBP_TO_EURO EURO_TO_GBP USD_TO_EURO EURO_TO_USD
%token CEL_TO_FAH FAH_TO_CEL MI_TO_KM KM_TO_MI VAR_KEYWORD EQUALS
%token <val> NUMBER    /* 'val' is the (only) field declared in %union
                       which represents the type of the token. */
%token <st> VARIABLE
%type <val> line calculation expr constant function log_function trig_function 
%type <val> conversion temp_conversion dist_conversion assignment

%left ADD SUB
%left MUL DIV MOD
%left POW FACTORIAL


%%

program         : /* empty */
                | program line                                              
                ;

line            : EOL                                                       { cout << endl; }
                | calculation EOL                                           { cout << "=" << fixed << setprecision(2) << double($1) << endl; }
                ;

calculation     : expr                                                      
                | assignment                                                
                ;

expr            : SUB expr                                                  { $$ = 0.0 - double($2); }
                | NUMBER                                                    { $$ = double($1); }
                | VARIABLE                                                  { $$ = get($1); }
                | constant                                                  { $$ = double($1); }
                | function                                                  { $$ = double($1); }
                | expr ADD expr                                             { $$ = double($1) + double($3); }
                | expr SUB expr                                             { $$ = double($1) - double($3); }
                | expr DIV expr                                             { $$ = double($1) / double($3); }
                | expr MUL expr                                             { $$ = double($1) * double($3); }
                | expr MOD expr                                             { $$ = modulo($1, $3); }
                | expr POW expr                                             { $$ = pow(double($1), double($3)); }
                | L_BRACKET expr R_BRACKET                                  { $$ = double($2); }
                ;

constant        : PI                                                        { $$ = 3.14; }
                ;

function        : conversion                                                { $$ = double($1); }
                | log_function                                              { $$ = double($1); }
                | trig_function                                             { $$ = double($1); }
                | expr FACTORIAL                                            { $$ = factorial(double($1)); }
                | SQRT expr                                                 { $$ = sqrt(double($2)); }
                | ABS expr                                                  { $$ = abs(double($2)); }
                | FLOOR expr                                                { $$ = floor(double($2)); }
                | CEIL expr                                                 { $$ = ceil(double($2)); }
                ;

log_function    : LOG2 expr                                                 { $$ = log2(double($2)); }
                | LOG10 expr                                                { $$ = log10(double($2)); }                  
                ;

trig_function   : COS expr                                                  { $$ = cos(double($2)); }
                | SIN expr                                                  { $$ = sin(double($2)); }
                | TAN expr                                                  { $$ = tan(double($2)); }
                ;

conversion      : temp_conversion                                           { $$ = double($1); }
                | dist_conversion                                           { $$ = double($1); }
                | expr GBP_TO_EURO                                          { $$ = gbp_to_euro(double($1)); }
                | expr GBP_TO_USD                                           { $$ = gbp_to_usd(double($1)); }
                | expr USD_TO_EURO                                          { $$ = usd_to_euro(double($1)); }
                | expr USD_TO_GBP                                           { $$ = usd_to_gbp(double($1)); }
                | expr EURO_TO_GBP                                          { $$ = euro_to_gbp(double($1)); }
                | expr EURO_TO_USD                                          { $$ = euro_to_usd(double($1)); }
                ;

temp_conversion : expr CEL_TO_FAH                                           { $$ = cel_to_fah(double($1)); }
                | expr FAH_TO_CEL                                           { $$ = fah_to_cel(double($1)); }
                ;

dist_conversion : expr MI_TO_KM                                             { $$ = mi_to_km(double($1)); }
                | expr KM_TO_MI                                             { $$ = km_to_mi(double($1)); }
                ;

assignment      : VAR_KEYWORD VARIABLE EQUALS calculation                   { $$ = assign($2, $4); }

%%


int main()
{
    yyparse(); // A parsing function that will be generated by Bison.
    return 0;
}
