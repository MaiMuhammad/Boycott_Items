:-consult(data).

:-dynamic item/3.
:-dynamic alternative/2.
:-dynamic boycott_company/2.

%Question 1:

%end 1

%Question 2:



%end 2


%Question 3:



%end 3

%Question 4:



getNumOfItems(Cname, Oid, Count):-
    getItemsInOrderById(Cname,Oid, List),
    lengthOfList(List, Count).

%end 4

%Question 5:



%end 5

%Question 6:

%end 6

%Question 7:



%end 7

%Question 8:

removeBoycottItem([],[]).
removeBoycottItem([FItem|List], NewList):-
    (   isBoycott(FItem) ->
    removeBoycottItem(List,NewList)
    ;
    removeBoycottItem(List, Temp),
    NewList = [FItem|Temp]
    ).

removeBoycottItemsFromAnOrder(Cname,Oid,NewList):-
    customer(Cid,Cname),
    order(Cid,Oid,List),
    removeBoycottItem(List, NewList), !.

%end 8

%Question 9:


%end 9

%Question 10:



%end 10

%Question 11:



%end 11


%Question 12:

add_item(Name,Company,Price):-
    assert(item(Name,Company,Price)).

remove_item(Name,Company,Price):-
    retract(item(Name,Company,Price)).

add_alternative(Item, Alt):-
    assert(alternative(Item, Alt)).

remove_alternative(Item, Alt):-
    retract(alternative(Item, Alt)).

add_boycott_company(Company, Justification):-
    assert(boycott_company(Company,Justification)).

remove_boycott_company(Company, Justification):-
    retract(boycott_company(Company, Justification)).

show_asserted_facts :-
    clause(fact(X), _),
    writeln(X),
    fail.
show_asserted_facts :- 
    writeln('End of asserted facts.').

%end 12
