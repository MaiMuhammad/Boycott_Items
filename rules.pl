:-consult(data).

:-dynamic item/3.
:-dynamic alternative/2.
:-dynamic boycott_company/2.

%Question 1:

concatinate([], L2, L2).
concatinate([H | T], L2, [H | R]) :-
	concatinate(T, L2, R).

addToBeg(L, E, R):-
	concatinate([E], L, R).


list_orders(CustUserName, OrdersList) :-
	get_orders(CustUserName, 1, [], OrdersList),!.

get_orders(CustUserName, OrderID, Orders, OrdersList) :-
	customer(CustomerID, CustUserName),
    order(CustomerID, OrderID, Items),
    NextOrderID is OrderID + 1,
	addToBeg(Orders, order(CustomerID, OrderID, Items), NewOrdersList),
    get_orders(CustUserName, NextOrderID, NewOrdersList, OrdersList).

get_orders(_, _, Orders, Orders).

%end 1

%Question 2:

lengthOfList([], 0).
lengthOfList([H|T], R):-
    lengthOfList(T, R1),
    R is 1 + R1.

countOrdersOfCustomer(CustUserName, Count):-
    list_orders(CustUserName, OrdersList),
    lengthOfList(OrdersList, Count).

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

isBoycott(CompanyName) :-
    boycott_company(CompanyName, _), !.

isBoycott(ItemName) :-
    item(ItemName, CompanyName, _),
    isBoycott(CompanyName).

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
