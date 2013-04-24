:- load_files(['../a1/bloodline.pl', 'lexicon.pl']).

verheiratet(X, Y)   :- married_to(X, Y). %X
bruder(X, Y)        :- brother_of(X, Y).
schwester(X, Y)     :- sister_of(X, Y).
geschwist(X, Y)     :- sibling_of(X, Y).
vater(X, Y)         :- father_of(X, Y).
mutter(X, Y)        :- mother_of(X, Y).
halbbruder(X, Y)    :- half_brother_of(X, Y).
halbschwester(X, Y) :- half_sister_of(X, Y).
halbgeschwist(X, Y) :- half_sibling_of(X, Y).
grossmutter(X, Y)   :- grandmother_of(X, Y).
grossvater(X, Y)    :- grandfather_of(X, Y).
vorfahre(X, Y)      :- ancestor_of(X, Y).
schwager(X, Y)      :- brother_in_law_of(X, Y).
schwaegerin(X, Y)   :- sister_in_law_of(X, Y).
cousin(X, Y)        :- male_cousin_of(X, Y).
cousine(X, Y)       :- female_cousin_of(X, Y).
elternteil(X, Y)    :- parent_of(X, Y).
onkel(X, Y)         :- uncle_of(X, Y).
tante(X, Y)         :- aunt_of(X, Y).

s(SemS,s(IP, VP, PP))           --> ip(IP, AGR),
                                    vp(SemVP, VP, AGR),
                                    pp(SemPP, PP, _),
                                    {
                                      SemVP = [_, _, X],
                                      call(X, Y, SemPP),
                                      SemS =.. [X, Y, SemPP]
                                    }.
s(SemS,s(VP, PN, NP, PP))       --> vp(_SemVP, VP, AGR),
                                    pn(SemPN, PN, PNAGR),
                                    np(SemNP, NP, AGR),
                                    pp(SemPP, PP, _),
                                    {
                                      agr(AGR_Num, AGR_Pers, _) = AGR,
                                      PNAGR = agr(AGR_Num, AGR_Pers, _),
                                      SemS =.. [SemNP, SemPN, SemPP]
                                    }.
s(SemS,s(VP, PN, NP, PP))       --> vp(_SemVP, VP, AGR),
                                    prae(_PRAE, AGR),
                                    pn(SemPN, PN, AGR),
                                    np(SemNP, NP, AGR),
                                    pp(SemPP, PP, AGR),
                                    {SemS =.. [SemNP, SemPN, SemPP]}.% verheiratet satz
np(SemN,np(DET,N),AGR)          --> det(DET, AGR), n(SemN, N, AGR).
np(SemN,np(N),AGR)              --> n(SemN, N, AGR).
np(SemN,np(N),AGR)              --> pn(SemN, N, AGR).
np(SemN,np(PP),AGR)             --> pp(SemN, PP, AGR).
vp([SemV,_,SemNP],vp(V,NP),AGR) --> v(SemV, V, AGR),
                                    np(SemNP, NP, AGR).
vp([SemV,_],vp(V), AGR)         --> v(SemV, V, AGR).
pp(SemPN, pp(PRAE, PN), AGR)    --> prae(PRAE, AGR),
                                    pn(SemPN, PN, AGR).
ip(ip(IP), AGR)                 --> [X], {lex(X, IP, ip, AGR)}.
% ip: agreement bei uns nicht wichtig. nur bei oertlichen interogativpronomen zB
prae(prae(PRAE), AGR)           --> [X], {lex(X, PRAE, prae, AGR)}.
n(SemN, n(SemN), AGR)           --> [X], {lex(X, SemN, n, AGR)}.
pn(SemPN, pn(SemPN), AGR)       --> [X], {lex(X, SemPN, pn, AGR)}.
v(SemV, v(SemV), AGR)           --> [X], {lex(X, SemV, v, AGR)}.
det(det(Det), AGR)              --> [X], {lex(X, Det, det, AGR)}.
