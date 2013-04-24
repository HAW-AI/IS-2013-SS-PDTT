onkel(hans, Y).
onkel(peter, Y).
%onkel(hans,peter).

s(SemS,s(NP,VP))                --> np(SemNP, NP, AGR), vp(SemVP, VP, AGR),
                                    {SemVP = [_, SemNP|_], SemS =.. SemVP}.
s(SemS,s(IP, VP, PP))           --> ip(IP, AGR), vp(SemVP, VP, AGR),
                                    pp(SemPP, PP, AGR),
                                    {SemVP = [_, _, X], call(X, Y, SemPP), SemS =.. [X, Y, SemPP]}.
s(SemS,s(VP, PN, NP, PP))       --> vp(SemVP, VP, AGR), pn(SemPN, PN, ARG),
                                    np(SemNP, NP, AGR), pp(SemPP, PP, AGR),
                                    {SemS =.. [SemNP, SemPN, SemPP]}.
np(SemN,np(DET,N),AGR)          --> det(DET, AGR), n(SemN, N, AGR).
np(SemN,np(N),AGR)          --> n(SemN, N, AGR).
np(SemN,np(N),AGR)              --> pn(SemN, N, AGR).
np(SemN,np(PP),AGR)             --> pp(SemN, PP, AGR).
vp([SemV,_,SemNP],vp(V,NP),AGR) --> v(SemV, V, AGR), np(SemNP, NP, _).
vp([SemV,_],vp(V), AGR)         --> v(SemV, V, AGR).
pp(SemPN, pp(PRAE, PN), AGR)    --> prae(PRAE, AGR), pn(SemPN, PN, AGR).
ip(ip(IP), AGR)                 --> [X], {lex(X, IP, ip, AGR)}.
% ip: agreement bei uns nicht wichtig. nur bei oertlichen interogativpronomen zB
prae(prae(PRAE), AGR)           --> [X], {lex(X, PRAE, prae, AGR)}.
n(SemN, n(SemN), AGR)           --> [X], {lex(X, SemN, n, AGR)}.
pn(SemPN, pn(SemPN), AGR)       --> [X], {lex(X, SemPN, pn, AGR)}.
v(SemV, v(SemV), AGR)           --> [X], {lex(X, SemV, v, AGR)}.
det(det(Det), AGR)              --> [X], {lex(X, Det, det, AGR)}.
