% House Targaryen
male(jaehrys_ii).
male(aerys_ii).
male(rhaenys).
male(aegon).
male(rhaegar).
male(viserys).
male(rhaego).

% Dothraki Horse Lord
male(khal_drogo).

% House Stark
male(jon_snow).
male(eddard).

% House Baratheon
male(steffon).
male(robert).
male(renly).
male(stannis).
male(joffrey).
male(tommen).

% House Lannister
male(tywin).
male(kevan).
male(lancel).
male(tyrion).
male(ser_jaime).
male(tytos).

% House Targaryen
female(rhaella).
female(elia).
female(daenerys).


% House Stark
female(sansa).
female(wylla).
female(catelyn).

% House Baratheon
female(myrcella).
% House Estermont
female(cassana).

% House Lannister
female(cersei).
female(joanna).
female(tytos_wife).

% House Swyft
female(dorna).

% for daenerys to have some cousins, a mother is needed
female(jaehrys_iis_love).

parent_of(jaehrys_iis_love, aerys_ii).
parent_of(jaehrys_iis_love, rhaella).


% House Targaryen
parent_of(elia, rhaenys).
parent_of(elia, aegon).
parent_of(rhaegar, rhaenys).
parent_of(rhaegar, aegon).
parent_of(daenerys, rhaego).
parent_of(khal_drogo, rhaego).
parent_of(aerys_ii, rhaegar).
parent_of(aerys_ii, viserys).
parent_of(aerys_ii, daenerys).
parent_of(rhaella, rhaegar).
parent_of(rhaella, viserys).
parent_of(rhaella, daenerys).
parent_of(jaehrys_ii, aerys_ii).
parent_of(jaehrys_ii, rhaella).

% House Stark
parent_of(eddard, jon_snow).
parent_of(eddard, sansa).
parent_of(wylla, jon_snow).
parent_of(catelyn, sansa).

% House Baratheon
parent_of(steffon, robert).
parent_of(steffon, renly).
parent_of(steffon, stannis).
parent_of(cassana, robert).
parent_of(cassana, renly).
parent_of(cassana, stannis).

parent_of(robert, joffrey).
parent_of(robert, myrcella).
parent_of(robert, tommen).
parent_of(cersei, joffrey).
parent_of(cersei, myrcella).
parent_of(cersei, tommen).

% House Lannister
parent_of(tytos, tywin).
parent_of(tytos, kevan).
parent_of(tytos_wife, tywin).
parent_of(tytos_wife, kevan).

parent_of(tywin, ser_jaime).
parent_of(tywin, cersei).
parent_of(tywin, tyrion).
parent_of(joanna, tyrion).
parent_of(joanna, ser_jaime).
parent_of(joanna, cersei).

parent_of(kevan, lancel).
parent_of(dorna, lancel).


% House Targaryen
marriage(aerys_ii, rhaella).
marriage(elia, rhaegar).
marriage(daenerys, khal_drogo).

% House Baratheon
marriage(steffon, cassana).
marriage(robert, cersei).

% House Lannister
marriage(tytos, tytos_wife).
marriage(tywin, joanna).
marriage(kevan, dorna).

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
  sibling_of(Brother, Sibling).

sister_of(Sister, Sibling) :-
  female(Sister),
  sibling_of(Sister, Sibling).


%% only works when children have two parents
half_brother_of(Brother, Sibling) :-
  male(Brother),
  half_sibling_of(Brother, Sibling).

%% only works when children have two parents
half_sister_of(Sister, Sibling) :-
  female(Sister),
  half_sibling_of(Sister, Sibling).


half_sibling_of(Person, HalfSibling) :-
  father_of(FatherOfPerson, Person),
  father_of(FatherOfHalfSibling, HalfSibling),

  mother_of(MotherOfPerson, Person),
  mother_of(MotherOfHalfSibling, HalfSibling),

  (FatherOfPerson == FatherOfHalfSibling ; MotherOfPerson == MotherOfHalfSibling),
  (FatherOfPerson \== FatherOfHalfSibling ; MotherOfPerson \== MotherOfHalfSibling),

  Person \== HalfSibling.


sibling_of(Person, Sibling) :-
  father_of(FatherOfPerson, Person),
  father_of(FatherOfSibling, Sibling),
  FatherOfPerson = FatherOfSibling,

  mother_of(MotherOfPerson, Person),
  mother_of(MotherOfSibling, Sibling),
  MotherOfPerson = MotherOfSibling,

  Person \== Sibling.

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


uncle_or_aunt_of(UncleAunt, NephewNiece) :-
  parent_of(Parent, NephewNiece),
  (sibling_of(UncleAunt, Parent) ; sibling_in_law_of(UncleAunt, Parent)).

uncle_of(Uncle, NephewNiece) :-
  uncle_or_aunt_of(Uncle, NephewNiece),
  male(Uncle).

aunt_of(Aunt, NephewNiece) :-
  uncle_or_aunt_of(Aunt, NephewNiece),
  female(Aunt).


cousin_of(Cousin, Person) :-
  parent_of(Parent, Person),
  sibling_of(SiblingOfParent, Parent),
  parent_of(SiblingOfParent, Cousin),
  Cousin \== Person.

male_cousin_of(MaleCousin, Person) :-
  cousin_of(MaleCousin, Person),
  male(MaleCousin).

female_cousin_of(FemaleCousin, Person) :-
  cousin_of(FemaleCousin, Person),
  male(FemaleCousin).




:- begin_tests(bloodline).

test(married_to) :-
  married_to(aerys_ii, rhaella).
test(married_to) :-
  married_to(rhaella, aerys_ii).

test(brother_of) :-
  brother_of(viserys, daenerys).
test(brother_of) :-
  not(brother_of(daenerys, viserys)).

test(sister_of) :-
  sister_of(daenerys, viserys).
test(sister_of) :-
  not(sister_of(viserys, daenerys)).

test(father_of) :-
  father_of(eddard, jon_snow).
test(father_of) :-
  father_of(eddard, sansa).
test(father_of) :-
  not(father_of(eddard, viserys)).
test(father_of) :-
  not(father_of(eddard, eddard)).

test(mother_of) :-
  mother_of(rhaella, rhaegar).
test(mother_of) :-
  mother_of(rhaella, daenerys).
test(mother_of) :-
  not(mother_of(rhaella, elia)).
test(mother_of) :-
  not(mother_of(rhaella, aegon)).

test(half_brother_of) :-
  half_brother_of(jon_snow, sansa).
test(half_brother_of) :-
  not(half_brother_of(sansa, jon_snow)).

test(half_sister_of) :-
  half_sister_of(sansa, jon_snow).
test(half_sister_of) :-
  not(half_sister_of(jon_snow, sansa)).

test(half_sibling_of) :-
  half_sibling_of(jon_snow, sansa).
test(half_sibling_of) :-
  half_sibling_of(sansa, jon_snow).

test(grandmother_of) :-
  grandmother_of(rhaella, aegon).
test(grandmother_of) :-
  not(grandmother_of(rhaella, viserys)).

test(grandfather_of) :-
  grandfather_of(aerys_ii, aegon).
test(grandfather_of) :-
  not(grandfather_of(aerys_ii, viserys)).

test(ancestor_of) :-
  ancestor_of(aerys_ii, aegon).
test(ancestor_of) :-
  ancestor_of(aerys_ii, viserys).
test(ancestor_of) :-
  not(ancestor_of(aerys_ii, rhaella)).
test(ancestor_of) :-
  not(ancestor_of(daenerys, viserys)).
test(ancestor_of) :-
  not(ancestor_of(daenerys, aerys_ii)).

test(sibling_in_law_of) :-
  sibling_in_law_of(khal_drogo, viserys).
test(sibling_in_law_of) :-
  sibling_in_law_of(viserys, khal_drogo).

test(brother_in_law_of) :-
  brother_in_law_of(khal_drogo, viserys).
test(brother_in_law_of) :-
  brother_in_law_of(viserys, khal_drogo).

test(sister_in_law_of) :-
  sister_in_law_of(elia, viserys).
test(sister_in_law_of) :-
  sister_in_law_of(daenerys, elia).

test(cousin_of) :-
  cousin_of(tyrion, lancel).
test(cousin_of) :-
  cousin_of(lancel, tyrion).

test(uncle_of) :-
  uncle_of(tywin, lancel).
test(uncle_of) :-
  uncle_of(kevan, ser_jaime).

:- end_tests(bloodline).
