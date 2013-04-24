:- load_files('../a1/bloodline.pl').

lex(wer, wer, ip, agr(_, _, _)).
lex(ist, sein, v, agr(sg, 3, _)).
lex(sind, sein, v, agr(pl, 1, _)).
lex(sind, sein, v, agr(pl, 3, _)).
lex(der, der, det, agr(sg, _, m)).
lex(die, die, det, agr(sg, _, f)).
lex(die, die, det, agr(pl, _, _)).
lex(das, das, det, agr(sg, _, n)).
lex(ein, ein, det, agr(sg, _, n)).
lex(ein, ein, det, agr(sg, _, m)).
lex(eine, eine, det, agr(sg, _, f)).

lex(onkel, onkel, n, agr(_, _, m)).
lex(tante, tante, n, agr(sg, _, f)).
lex(tanten, tante, n, agr(pl, _, f)).

lex(bruder, bruder, n, agr(sg, _, m)).
lex(halbbruder, halbbruder, n, agr(sg, _, m)).
lex(schwester, schwester, n, agr(sg, _, f)).
lex(halbschwester, halbschwester, n, agr(sg, _, f)).

lex(geschwist, geschwist, n, agr(sg, _, _)).
lex(geschwister, geschwist, n, agr(pl, _, _)).

lex(vater, vater, n, agr(sg, _, m)).
lex(mutter, mutter, n, agr(sg, _, f)).
lex(grossvater, grossvater, n, agr(sg, _, m)).
lex(grossmutter, grossmutter, n, agr(sg, _, f)).
lex(vorfahre, vorfahre, n, agr(sg, _, m)).
lex(vorfahrin, vorfahre, n, agr(sg, _, f)).
lex(vorfahren, vorfahre, n, agr(pl, _, _)).


lex(verheiratet, verheiratet, n, agr(sg, _, _)).
lex(schwager, schwager, n, agr(sg, _, m)).
lex(schwaeger, schwager, n, agr(pl, _, m)).
lex(schwaegerin, schwaegerin, n, agr(sg, _, f)).
lex(schwaegerinnen, schwaegerin, n, agr(pl, _, f)).

lex(cousin, cousin, n, agr(sg, _, m)).
lex(cousins, cousin, n, agr(pl, _, m)).
lex(cousine, cousine, n, agr(sg, _, f)).
lex(cousinen, cousine, n, agr(pl, _, f)).

lex(elternteil, elternteil, n, agr(sg, _, m)).
lex(eltern, elternteil, n, agr(pl, _, f)).

lex(von, von, prae, agr(_, _, _)).
lex(mit, mit, prae, agr(_, _, _)).


lex(PN, PN, pn, agr(sg, 3, m)) :- male(PN).
lex(PN, PN, pn, agr(sg, 3, f)) :- female(PN).
