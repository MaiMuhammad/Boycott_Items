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

getItemsInOrderById(CustUserName, OrderID, Items) :-
	customer(CustID, CustUserName),
	order(CustID, OrderID, Items), !.

%end 3

%Question 4:



getNumOfItems(Cname, Oid, Count):-
    getItemsInOrderById(Cname,Oid, List),
    lengthOfList(List, Count).

%end 4

%Question 5:

calcPriceOfOrder(CustomerName, OrderID, TotalPrice) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderID, Items),
    calcPrice(Items, TotalPrice).

calcPrice([], 0).
calcPrice([H|T], TotalPrice) :-
    item(H, _, Price),
    calcPrice(T, NewPrice),
    TotalPrice is Price + NewPrice.

%end 5

%Question 6:

isBoycott(CompanyName) :-
    boycott_company(CompanyName, _), !.

isBoycott(ItemName) :-
    item(ItemName, CompanyName, _),
    isBoycott(CompanyName).

%end 6

%Question 7:

whyToBoycott(CompanyName, Justification):-
    boycott_company(CompanyName, Justification), !.

whyToBoycott(ItemName, Justification):-
    item(ItemName, CompanyName, _),
    boycott_company(CompanyName, Justification).

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

replace([], []).
replace([Item|RemainingItems], [H|T]):-
    isBoycott(Item),
    alternative(Item, AlternativeItem),
    H = AlternativeItem,
    replace(RemainingItems, T).

replace([Item|RemainingItems], [Item|T]):-
    replace(RemainingItems, T).

replaceBoycottItemsFromAnOrder(CustUserName, OID, NewList):-
    customer(CID,CustUserName),
    order(CID, OID, Items),
    replace(Items, NewList), !.

%end 9

%Question 10:

calcTotalPrice([], 0).
calcTotalPrice([Item|RemainingItems], Total):-
    item(Item, _, ItemPrice),
    calcTotalPrice(RemainingItems, SubTotal),
    Total is ItemPrice + SubTotal.

calcPriceAfterReplacingBoycottItemsFromAnOrder(CustUserName, OID, NewList, TotalPrice):-
    replaceBoycottItemsFromAnOrder(CustUserName, OID, NewList),
    calcTotalPrice(NewList, TotalPrice).

%end 10
%Question 11:

getTheDifferenceInPriceBetweenItemAndAlternative(ItemName, AlternativeItem, DiffPrice) :-
    alternative(ItemName, AlternativeItem),
    item(ItemName, _, ItemPrice),
    item(AlternativeItem, _, AlternativeItemPrice),
    DiffPrice is ItemPrice - AlternativeItemPrice.

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
