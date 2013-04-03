male(aerys_ii).
male(khal_drogo).
male(rhaenys).
male(aegon).
male(rhaegar).
male(viserys).

male(john_snow).
male(eddard).
female(sansa).
%% female(wylla).
%% female(catelyn).

female(rhaella).
female(elia).
female(daenerys).


parent_of(elia, rhaenys).
parent_of(elia, aegon).
parent_of(rhaegar, rhaenys).
parent_of(rhaegar, aegon).
parent_of(aerys_ii, rhaegar).
parent_of(aerys_ii, viserys).
parent_of(aerys_ii, daenerys).
parent_of(rhaella, rhaegar).
parent_of(rhaella, viserys).
parent_of(rhaella, daenerys).

%% parent_of(eddard, john_snow).
%% parent_of(eddard, sansa).
%% parent_of(wylla, john_snow).
%% parent_of(catelyn, sansa).


marriage(aerys_ii, rhaella).
marriage(elia, rhaegar).
marriage(daenerys, khal_drogo).

married_to(Husband, Spouse) :- marriage(Husband, Spouse).
married_to(Spouse, Husband) :- marriage(Husband, Spouse).



mother_of(Mother, Child) :-
  female(Mother),
  parent_of(Mother, Child).


father_of(Father, Child) :-
  male(Father),
  parent_of(Father, Child).


grandmother_of(Grandmother, Grandchild) :-
  parent_of(Parent, Grandchild),
  mother_of(Grandmother, Parent).

grandfather_of(Grandfather, Grandchild) :-
  parent_of(Parent, Grandchild),
  father_of(Grandfather, Parent).


ancestor_of(Ancestor, Person) :-
  parent_of(Ancestor, Person).

ancestor_of(Ancestor, Person) :-
  parent_of(Parent, Person),
  ancestor_of(Ancestor, Parent).


brother_of(Brother, Sibling) :-
  male(Brother),

  father_of(FatherOfBrother, Brother),
  father_of(FatherOfSibling, Sibling),
  FatherOfBrother = FatherOfSibling,

  mother_of(MotherOfBrother, Brother),
  mother_of(MotherOfSibling, Sibling),
  MotherOfBrother = MotherOfSibling,

  Brother \== Sibling.


sister_of(Sister, Sibling) :-
  female(Sister),

  father_of(FatherOfSister, Sister),
  father_of(FatherOfSibling, Sibling),
  FatherOfSister = FatherOfSibling,

  mother_of(MotherOfSister, Sister),
  mother_of(MotherOfSibling, Sibling),
  MotherOfSister = MotherOfSibling,

  Sister \== Sibling.


%% only works when children have two parents
half_brother_of(Brother, Sibling) :-
  male(Brother),

  father_of(FatherOfBrother, Brother),
  father_of(FatherOfSibling, Sibling),

  mother_of(MotherOfBrother, Brother),
  mother_of(MotherOfSibling, Sibling),

  (FatherOfBrother == FatherOfSibling ; MotherOfBrother == MotherOfSibling),
  (FatherOfBrother \== FatherOfSibling ; MotherOfBrother \== MotherOfSibling),

  Brother \== Sibling.


%% only works when children have two parents
half_sister_of(Sister, Sibling) :-
  female(Sister),

  father_of(FatherOfSister, Sister),
  father_of(FatherOfSibling, Sibling),

  mother_of(MotherOfSister, Sister),
  mother_of(MotherOfSibling, Sibling),

  (FatherOfSister == FatherOfSibling ; MotherOfSister == MotherOfSibling),
  (FatherOfSister \== FatherOfSibling ; MotherOfSister \== MotherOfSibling),

  Sister \== Sibling.


sibling_of(Brother, Sibling) :- brother_of(Brother, Sibling).
sibling_of(Sister, Sibling) :- sister_of(Sister, Sibling).

sibling_in_law_of(SiblingInLaw, Person) :-
  married_to(Person, Spouse),
  sibling_of(SiblingInLaw, Spouse).

sibling_in_law_of(SiblingInLaw, Person) :-
  sibling_of(Spouse, Person),
  married_to(Spouse, SiblingInLaw).

brother_in_law_of(BrotherInLaw, Person) :-
  sibling_in_law_of(BrotherInLaw, Person),
  male(BrotherInLaw).

sister_in_law_of(SisterInLaw, Person) :-
  sibling_in_law_of(SisterInLaw, Person),
  female(SisterInLaw).

uncle_of(Uncle, NephewNiece) :-
  parent_of(Parent, NephewNiece),
  (sibling_of(Uncle, Parent) ; brother_in_law_of(Uncle, Parent)),
  male(Uncle).

aunt_of(Aunt, NephewNiece) :-
  parent_of(Parent, NephewNiece),
  (sibling_of(Aunt, Parent) ; sister_in_law_of(Aunt, Parent)),
  female(Aunt).