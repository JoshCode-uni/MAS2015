%% *************************
%% ** BGN getWeapon.mod2g **
%% *************************

	% [PlaceHolder] weapon/3 initiator to correct weird GOAL behaviour.
	weapon(none,none,none).
	
	% [PlaceHolder] item/4 initiator to correct weird GOAL behaviour.
	item(none,none,none,none).
	
	% weapon priority list, contains hardList without worse weapons then the ones in inventory.
	% Input requirement: insert hardList to start. List is output.
    priorities([HH|HT], Wep) :-Wep = HH;
                               (
                               not(weapon(HH)),
                               priorities(HT,Wep)
                               ).
    priorities([],_).
	
	% Hardcode base priorities list. 
	hardList(List) :- List = [flak, stinger, linkgun, shockrifle, rocketlauncher, biorifle, sniperrifle].
	
	% gives true if want weapon.
	wantWep(Weapon) :- hardList(HARD),
                       priorities(HARD, Weapon),
                       member(Weapon, HARD),
                       not(weapon(Weapon)).
	
	% getWep(Type) is true if it is in inventory.
	getWep(Weapon) :- (weapon(Weapon,_,_)).


%% *************************
%% ** END getWeapon.mod2g **
%% *************************

%% *************************
%% ** BGN getArmour.mod2g **
%% *************************
	
% wantArmor(Armor) is true if Armor is a wanted piece of armor.
wantArmor(Armor) :- armor(Helmet,Vest,Pants,Belt), ((Armor = 'armor_helmet', Helmet == 0); 
		(Armor = 'armor_vest', Vest == 0); 
		(Armor = 'armor_shield_belt', Belt == 0); 
		(Armor = 'armor_thighpads', Pants == 0)).

%% *************************
%% ** END getArmour.mod2g **
%% *************************

%% ***********************
%% ** BGN Carrier.mod2g **
%% ***********************

% calculate the length of a path from starting point to end point
calculatePath(StartID, EndID) :- path(StartID, EndID, _, _).

% Take the flag from the component. We are at a certain location if the IDs match.
takeFlag(UnrealID) :- navigation(reached, UnrealID).

% Pick up our flag of the ground. We are at a certain location if the IDs match.
pickUpFlag(UnrealID) :- navigation(reached, UnrealID).
	
% Bring the flag back home to our base. We are at a certain location if the IDs match.
bringBackFlag(UnrealID) :- navigation(reached, UnrealID).

%!!!!!!!!!!!!!!!!!!!!!!!!!%
% TEMPORARY GOAL (will be replaced for modules getHealth and getWeapon). Grab closeby stuff. We are at a certain location if the IDs match.
grabStuff(UnrealID) :- navigation(reached, UnrealID).
	
%% ***********************
%% ** END Carrier.mod2g **
%% ***********************

%% ************************
%% ** BGN Defender.mod2g **
%% ************************

		% myTeam(?Team).
		myTeam(Team) :- self(_,_,Team).
		% enemy(+UnrealID).
		enemy(UnrealID) :- myTeam(Team), bot(UnrealID, _, OtherTeam, _, _, _), not(Team = OtherTeam).
		
		% Go to a destination. We are at a certain location if the IDs match.
		goTo(UnrealID) :- navigation(reached, UnrealID).
		
%% ************************
%% ** END Defender.mod2g **
%% ************************

%% **********************
%% ** BGN Roamer.mod2g **
%% **********************
														
		% true if list contains X.
		listCon([H|T], X) :- H = X;
							listCon(T, X).
		
		% get weapon inventory in list form.
		wepList(List) :- weapon(X,_,_),
							listCon(List, X).

%% **********************
%% ** END Roamer.mod2g **
%% **********************

%% *********************
%% ** BGN ALL MODULES **
%% *********************

%goalStack(Stack) :- Stack = [].

%pushStack(Element) :- .
%popStack(Element) :- goalStack([H|Tail]), ELement = H.

% Prefer these weapons given the range to enemy.
preferedWeapons(WeaponList, Range) :- (Range = "short", WeaponList = [weapon(link_gun, primary), weapon(flak_cannon, primary), weapon(stinger_minigun, primary)]) ;
					(Range = "mid", WeaponList = [weapon(flak_cannon, primary), weapon(stinger_minigun, primary), weapon(shock_rifle, primary)]) ;
					(Range = "long", WeaponList = [weapon(stinger_minigun, primary), weapon(shock_rifle, primary)]).

%% *********************
%% ** END ALL MODULES **
%% *********************
