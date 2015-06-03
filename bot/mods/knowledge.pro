%% *************************
%% ** BGN getWeapon.mod2g **
%% *************************

% [PlaceHolder] weapon/3 initiator to correct weird GOAL behaviour.
weapon(none,none,none).

% [PlaceHolder] item/4 initiator to correct weird GOAL behaviour.
item(none,none,none,none).

% get weapon inventory in list form.
wepList(List) :- weapon(X,_,_),
not(member(X, List)),
wepList([X|List]).

% weapon priority list, contains hardList without worse weapons then the ones in inventory.
% Input requirement: insert hardList to start. List is output.
priorities(List, Hlist) :- Hlist = [HH|TH],
wepList(Inv),
((not(member(HH,Inv)),
priorities([HH|List], TH));
(member(HH, Inv),
priorities(List, TH))).
priorities(X, []).

% Hardcode base priorities list. 
hardList(List) :- List = [flak, stinger, linkgun, shockrifle, rocketlauncher, biorifle, sniperrifle].

% gives true if want weapon.
wantWep(Weapon) :- hardList(HARD),
priorities(List, HARD),
member(Weapon, List).

% getWep(Type) is true if it is in inventory.
getWep(Weapon) :- (weapon(Weapon,_,_)).

%% *************************
%% ** END getWeapon.mod2g **
%% *************************