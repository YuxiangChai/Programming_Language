/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_YC3743_CALC_TAB_H_INCLUDED
# define YY_YY_YC3743_CALC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    L_BRACKET = 258,
    R_BRACKET = 259,
    EOL = 260,
    DIV = 261,
    MUL = 262,
    ADD = 263,
    SUB = 264,
    POW = 265,
    MOD = 266,
    PI = 267,
    SQRT = 268,
    ABS = 269,
    FLOOR = 270,
    CEIL = 271,
    LOG2 = 272,
    LOG10 = 273,
    FACTORIAL = 274,
    COS = 275,
    SIN = 276,
    TAN = 277,
    GBP_TO_USD = 278,
    USD_TO_GBP = 279,
    GBP_TO_EURO = 280,
    EURO_TO_GBP = 281,
    USD_TO_EURO = 282,
    EURO_TO_USD = 283,
    CEL_TO_FAH = 284,
    FAH_TO_CEL = 285,
    MI_TO_KM = 286,
    KM_TO_MI = 287,
    VAR_KEYWORD = 288,
    EQUALS = 289,
    NUMBER = 290,
    VARIABLE = 291
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 31 "yc3743.calc.y"

    double val;
    char* st;
    /* You may include additional fields as you want. */
    /* char op; */

#line 101 "yc3743.calc.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YC3743_CALC_TAB_H_INCLUDED  */
