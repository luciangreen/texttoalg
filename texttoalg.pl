%% Load with ['../Text-to-Breasonings/text_to_breasonings.pl'].
%% and ['texttoalg'].
%% Run with texttoalg(u,u,u,u,true,true,true,true,true,true).
%% or texttoalg(u,u,u,u,true,false,false,false,false,false).
%% or texttoalg(8,u,u,2000,true,false,false,false,false,false). for PhD (16k words per algorithm)

%% Important: See instructions for using texttobr.pl at https://lucianpedia.wikia.com/wiki/Instructions_for_Using_texttobr(2).pl .

%% use_module(library(pio)). %% In la_strings
%% use_module(library(dcg/basics)). %% In la_strings

%% texttobr2 - converts file stream to dimensions of objects represented by the words
%% has object name as separate field for new users of texttobr to verify breasonings by hand
%% brdict1.txt contains word and object name, brdict2.txt contains object name and x, y and z

%% texttobr2(Runs,File,StringtoBreason,BreasoningLimit).
:- include('../Text-to-Breasonings/mergetexttobrdict.pl').
:- include('../listprologinterpreter/la_strings').
:- use_module(library(date)).

%% Brth is true or false
texttoalg(N1,Filex1,Stringx1,M1,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish) :-

	((number(N1),N=N1)->true;
	(N1=u,N=1)),

	((Filex1=u,Filex="file.txt")->true;
	Filex=Filex1),

	((number(M1),M=M1)->true;
	M=all), %% If m1 is undefined or all then m=all

	prep(List1,BrDict03,BrDict03t,Filex,Stringx1,M),
	term_to_atom(List1,List1A),atom_string(List1A,List1B),string_concat(List1B,"\n\n",List1C),
	br2(List1,BrDict03,BrDict2,BrDict03t,BrDict03t2,1,List1C,Shell2,N,M,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish),
	sort(BrDict2,BrDict3),
	(BrDict03=BrDict3->true;
	(open_s("algdict1.txt",write,Stream),
%%	string_codes(BrDict3),
term_to_atom(BrDict3,BrDict31),
	write(Stream,BrDict31),
	close(Stream))),

	sort(BrDict03t2,BrDict03t3),
	(BrDict03t=BrDict03t3->true;
	(open_s("algdict2.txt",write,Stream2),
%%	string_codes(BrDict3),
	term_to_atom(BrDict03t3,BrDict03t31),
	write(Stream2,BrDict03t31),
 	close(Stream2))),
 	
 			get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),
	concat_list("file",[Year,Month,Day,Hour1,Minute1,Seconda],File1),
	concat_list(File1,[".txt"],File2),


	(open_s(File2,write,Stream1),
%%	string_codes(BrDict3),
	write(Stream1,Shell2),
	close(Stream1)),

 	!.


replace0(Input,Find,Replace,SepandPad,M,Output0) :-
	replace00(Input,Find,Replace,SepandPad,[],Output1),
	truncate(Output1,M,Output0),!.
replace00([],_Find,_Replace,_SepandPad,Input,Input) :- !.
replace00(Input1,Find,Replace,SepandPad,Input2,Input3) :-
	Input1=[Input4|Input5],
	string_codes(Input4,String1),
	replace1(String1,Find,Replace,[],Input7),
	string_codes(Output,Input7),
	split_string(Output,SepandPad,SepandPad,Input8),
	append(Input2,Input8,Input9),
	replace00(Input5,Find,Replace,SepandPad,Input9,Input3), !.
replace1([],_Find,_Replace,Input,Input) :- !.
replace1(Input1,Find,Replace,Input2,Input3) :-
	Input1=[Input4|Input5],
	member(Input4,Find),
	append(Input2,[Replace],Input6),
	replace1(Input5,Find,Replace,Input6,Input3), !.
replace1(Input1,Find,Replace,Input2,Input3) :-
	Input1=[Input4|Input5],
	not(member(Input4,Find)),
	append(Input2,[Input4],Input6),
	replace1(Input5,Find,Replace,Input6,Input3), !.

split_string_onnonletter(String00,List1) :-
	string_codes(String00,String1),
	split_string_onnonletter(String1,[],List0),
	string_codes(List0,List2),
	split_string(List2," "," ",List1),!.
split_string_onnonletter([],Input,Input) :- !.
split_string_onnonletter(Input1,Input2,Input3) :-
	Input1=[Input4|Input5],
	not(char_type(Input4,alpha)),
	append(Input2,[32],Input6),
	split_string_onnonletter(Input5,Input6,Input3), !.
split_string_onnonletter(Input1,Input2,Input3) :-
	Input1=[Input4|Input5],
	char_type(Input4,alpha),
	append(Input2,[Input4],Input6),
	split_string_onnonletter(Input5,Input6,Input3), !.

%% Truncates the list if m is not undefined and m is greater than or equal to the length of string0
truncate(List1,M,String0) :-
	((number(M),length(String0,M),
	append(String0,_,List1))->true;
	String0=List1),!.
	
prep(List,BrDict03,BrDict03t,Filex,Stringx1,M) :-
	phrase_from_file_s(string(BrDict0), "algdict1.txt"),
	%%Chars="’",
	SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	%%split_string(BrDict0,SepandPad,SepandPad,BrDict01),
%%writeln([brDict0,BrDict0]),
%%writeln([brdict1]),
string_atom(BrDict0,Atom),atom_to_term(Atom,BrDict01,_),
	%%splitfurther(BrDict0,BrDict01),
%%writeln([brDict01,BrDict01]),
	%%char_code(Escape,27),
	%%delete(BrDict01,[Escape,_,_,_,_],BrDict021),
%%writeln([brDict021,BrDict021]),
	%%char_code(Apostrophe,8217),
	%%delete(BrDict021,[Apostrophe,_,_,_,_],BrDict02),
%%writeln([brDict02,BrDict02]),
	sort(BrDict01,BrDict03),
%%writeln([brDict03,BrDict03]),
	length(BrDict03,Length0),write("Number of words in dictionary: "), writeln(Length0),
	
	%%writeln(''),
	%%writeln([brdict2]),
	phrase_from_file_s(string(BrDict0t), "algdict2.txt"),
	%%Chars="’",
	%%split_string(BrDict0,SepandPad,SepandPad,BrDict01),
%%writeln([brDict0,BrDict0]),
%%	splitfurthert(BrDict0t,BrDict01t),
string_atom(BrDict0t,Atom2),atom_to_term(Atom2,BrDict01t,_),
%%writeln([brDict01,BrDict01]),
	%%delete(BrDict01t,[Escape,_,_,_,_],BrDict021t),
%%writeln([brDict021,BrDict021]),
	%%delete(BrDict021t,[Apostrophe,_,_,_,_],BrDict02t),
%%writeln([brDict02,BrDict02]),
	sort(BrDict01t,BrDict03t),
%%writeln([brDict03,BrDict03]),
	length(BrDict03t,Length0t),write("Number of unique algorithms in dictionary: "), writeln(Length0t),
	
	((Stringx1=u,
	phrase_from_file_s(string(String00), Filex))->true;
	String00=Stringx1),
	
	split_string(String00,SepandPad,SepandPad,List1),
	%%split_string_onnonletter(String00,List1),

	truncate(List1,M,List),

	/**replace0(String0,[8221, 8220], 34, SepandPad, M, String1),
	replace0(String1,[8216, 8217], 39, SepandPad, M, String2),
	replace0(String2,[8259, 8211, 8212], 45, SepandPad, M, String3),
	replace0(String3,[160], 32, SepandPad, M, List),
	**/

%%atom_codes(Atom999,String),writeln([atom999,Atom999]),

%%writeln([list,List]),
	%%delete(List,Escape,List11),
%%writeln([list11,List11]),
	%%delete(List11,Apostrophe,List1),
%%writeln([list1,List1]),
	length(List,Length1),write("Number of words to breason out algorithms for in file: "), writeln(Length1),
	sort(List,List2),
%%writeln([list2,List2]),
	length(List2,Length2),write("Number of unique words in file: "), writeln(Length2),
	

	((Stringx1=u, %% Use file, not string as input.
	
	%%maplist(downcase_atom, List2, List3),
	maplist(string_lower, List2, List3),
	
%%writeln([list3,List3]),
	towords3(BrDict03,[],BrDict04,[],_ObjectNames,[],AllUsedNames),
	towords2(BrDict03t,[],BrDict04t),

%%writeln([brDict04,BrDict04]),
	subtract(List3,BrDict04,D1),
%%writeln([list3,brDict04,d1,List3,BrDict04,D1]),
%%writeln(["subtract(BrDict04,List3,D1).",List3,BrDict04,D1]),	
	length(D1,Length01),Difference is abs(Length01),write("Number of words remaining to define: "), writeln(Difference),

	subtract(AllUsedNames,BrDict04t,D2),
	%%delete(D21,'',D2),
	length(D2,Length01t),Differencet is abs(Length01t),write("Number of undefined algorithms: "), writeln(Differencet),
	%% writeln([undefinedalgorithms,D2]), %% Print undefined algorithms

	%%delete(D31,'',D3),
	subtract(BrDict04t,AllUsedNames,D3),
	length(D3,Length01t2),Differencet2 is abs(Length01t2),write("Number of orphaned algorithms: "), writeln(Differencet2)
	
		%%,writeln([orphanedalgorithms,D3]) %% Print orphaned algorithms
	
	
	

)->true;(string(Filex),writeln("Number of words, unique words, unique breathsonings, words remaining to define, undefined breasonings, orphaned breasonings, undefined breathsonings and orphaned breathsonings skipped for speed when breasoning out a string."))),!.

br2(_,A,A,B,B,0,Shell,Shell,_N1,_M1,_Brth,_Room,_PartOfRoom,_Direction,_ObjectToPrepare,_ObjectToFinish) :- !.
br2(List1,BrDict03,BrDict2,BrDict03t,BrDict03t2,N1,Shell1,Shell2,N11,M1,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish) :-
	br(List1,BrDict03,BrDict21,BrDict03t,BrDict03t21,Shell1,Shell3,N11,M1,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish),
	N2 is N1-1,
	br2(List1,BrDict21,BrDict2,BrDict03t21,BrDict03t2,N2,Shell3,Shell2,N11,M1,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish),!.

towords2([],A,A) :- !.
towords2(BrDict03,A,B) :-
	BrDict03=[[Word,_,_,_]|Rest],
	%%atom_string(Atom,Word),
	append(A,[Word],C),
	towords2(Rest,C,B).

towords2a([],A,A) :- !.
towords2a(BrDict03,A,B) :-
	BrDict03=[[Word,_]|Rest],
	%%atom_string(Atom,Word),
	append(A,[Word],C),
	towords2a(Rest,C,B).

towords3([],A,A,C,C,D,D) :- !.
towords3(BrDict03,A,B,D,E,G,H) :-
	BrDict03=[[Word1,Word2]|Rest],
	(Word2=""->append(G,[Word1],I)->true;
	append(G,[Word2],I)),
	append(A,[Word1],C),
	append(D,[Word2],F),
	towords3(Rest,C,B,F,E,I,H).

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

splitfurther(BrDict01,N) :-
	   phrase(file0(N),BrDict01).
	
file0(N) --> "[", file(N), "]", !.
file0([]) --> [].

%%file([]) --> [].
file([L|Ls]) --> entry(L),",",
%%{writeln(L)}, %%***
file(Ls), !. %% file(Ls),{M=[Ls]})), !. %%, {writeln(["l",L])},",", file(Ls), {writeln(["ls",Ls])},!. %%, {append(L,Ls,M)}, !.	
file([L]) --> entry(L), 
%%{writeln(L)},
!. %%(entry(L),{M=L});{M=[],(writeln("Warning - Entry in incorrect format.")
%%,abort
%%)}, !.

entry([Word2,Word4]) -->
		"[", word(Word), {string_codes(Word2,Word),string(Word2)},
		",",
           word(Word3), {string_codes(Word4,Word3),string(Word4)},
           "]".

splitfurthert(BrDict01,N) :-
	   phrase(file0t(N),BrDict01).
	
file0t(N) --> "[", filet(N), "]", !.
file0t([]) --> [].

%%file([]) --> [].
filet([L|Ls]) --> entryt(L),",",
%%{writeln(L)}, %%***
filet(Ls), !. %% file(Ls),{M=[Ls]})), !. %%, {writeln(["l",L])},",", file(Ls), {writeln(["ls",Ls])},!. %%, {append(L,Ls,M)}, !.	
filet([L]) --> entryt(L), 
%%{writeln(L)},
!. %%(entry(L),{M=L});{M=[],(writeln("Warning - Entry in incorrect format.")
%%,abort
%%)}, !.

entryt([Word2,X3,Y3,Z3]) -->
		"[", word(Word), {string_codes(Word2,Word),string(Word2)},
		",",
	      digits(X),",",{atom_codes(X2,X),atom_number(X2,X3),number(X3)},
           digits(Y),",",{atom_codes(Y2,Y),atom_number(Y2,Y3),number(Y3)},
           digits(Z),{atom_codes(Z2,Z),atom_number(Z2,Z3),number(Z3)},
           "]".

word([X|Xs]) --> [X], {char_type(X,csymf)->true;(X=27->true;X=8217)}, word(Xs), !.
%%word([X]) --> [X], {char_type(X,csymf);(X=27;X=8217)}, !.
word([]) --> [].

digits([X|Xs]) --> [X], {(char_type(X,digit)->true;(string_codes(Word2,[X]),Word2="."))}, digits(Xs), !.
%%digits([X]) --> [X], {(char_type(X,digit);(string_codes(Word2,[X]),Word2="."))}, !.
digits([]) --> [].

br([],B,B,C,C,Shell,Shell,_N1,_M1,_Brth,_Room,_PartOfRoom,_Direction,_ObjectToPrepare,_ObjectToFinish) :-
	!.
br([Word|Words],BrDict,BrDict2,BrDict4,BrDict5,Shell1,Shell2,N1,M1,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish) :-
	downcase_atom(Word, Word2), atom_string(Word2,Word3),
	
	/**member([Word3,X,Y,Z],BrDict4) -> %% This feature is a bug because words in brdict2 shouldn't necessarily be the words in brdict1
	%%(append(BrDict,[[Word3,""]],BrDict3), BrDict3t=BrDict4,
	%%br(Words,BrDict3,BrDict2,BrDict3t,BrDict5))
	%%;
	%%(**/
	
	%%(member([Word3,X,Y,Z],BrDict4) -> %% This feature is a bug because words in brdict1 should correspond to those in brdict2
	%%(atom_concat("The breasoning for ", Word3, P1),
	%%atom_concat(P1, " is defined.  Enter object name (without spaces), if different for ", Prompt));
	%Prompt="Enter object name (without spaces), if different for "),
	
	%%writeln([word3,Word3]),
	
	(member([Word3,String4],BrDict)-> 
	BrDict3=BrDict;
	((repeat,
	write("Enter algorithm name (without spaces), if different for "), writeln(Word3),read_string(user_input, "\n", "\r", _End2, String2),split_string(String2, "", " ", String3),String3=[String4]),
	append(BrDict,[[Word3,String4]],BrDict3),
	texttobr(1,u,String4,1))),
	%%*brth(Word3,_Brth),

(String4=""->String5=Word3;String5=String4),

	downcase_atom(String5, String52), atom_string(String52,String53),

	(member([String53,Query,Algorithm,Result],BrDict4)->
	BrDict3t1=BrDict4;
	((repeat,
	write("Enter specification, algorithm and result for "), writeln(String53),read_string(user_input, "\n", "\r", _End, String),term_to_atom(Values,String),%% ",", " ", Values),
	Values=(Query,Algorithm,Result),%%number_string(X,X1),number_string(Y,Y1),number_string(Z,Z1)),
	append(BrDict4,[[String53,Query,Algorithm,Result]],BrDict3t1)))->true;true),
	%%*brth(String53,_Brth2),
	%%write("br(\'"),write(Word3),writeln("\',)."),
%%	writeln([Word3,X,Y,Z]),
	%%write(' '),

term_to_atom(Query,Query1),
term_to_atom(Algorithm,Algorithm1),
term_to_atom(Result,Result1),
concat_list([Shell1,"swipl -G100g -T20g -L2g\n[listprolog].\nleash(-all),visible(+all),protocol(\"./file1.txt\"),trace,interpret(off,",Query1,",",Algorithm1,",",Result1,"),notrace,noprotocol.\nhalt.\nswipl -G100g -T20g -L2g\n['../Text-to-Breasonings/text_to_breasonings.pl'].\ntime((N = ",N1,",","M = ",M1,", texttobr2(N,\"file1.txt\",u,M,",Brth,",",Room,",",PartOfRoom,",",Direction,",",ObjectToPrepare,",",ObjectToFinish,"),texttobr(N,\"file1.txt\",u,M))).\nhalt.\n\n"],Shell3),

br(Words,BrDict3,BrDict2,BrDict3t1,BrDict5,Shell3,Shell2,N1,M1,Brth,Room,PartOfRoom,Direction,ObjectToPrepare,ObjectToFinish).
	%%).
brth(_,sweetinvincibleandprayedfor).

%% finds unknown words, asks for their br in form "n of m: word", verify, (can go back x) append and sort, save