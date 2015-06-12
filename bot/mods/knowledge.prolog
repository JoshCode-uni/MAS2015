%% *********************
%% ** BGN ALL MODULES **
%% *********************

% We are at a certain location if the IDs match, or ...
at(UnrealID) :- navigation(reached, UnrealID).
% if the coordinates are approximately equal.
at(location(X, Y, Z)) :- navigation(reached, location(X1, Y1, Z1)), 
	round(X) =:= round(X1), round(Y) =:= round(Y1), round(Z) =:= round(Z1).

% myTeam(?Team).
myTeam(Team) :- self(_,_,Team).
% enemy(+UnrealID).
enemy(UnrealID) :- myTeam(Team), bot(UnrealID, _, OtherTeam, _, _, _), not(Team = OtherTeam).

% Prefer these weapons given the range to enemy.
preferedWeapons(WeaponList, Range) :- (Range = "short", WeaponList = [weapon(link_gun, primary), weapon(flak_cannon, primary), weapon(stinger_minigun, primary)]) ;
					(Range = "mid", WeaponList = [weapon(flak_cannon, primary), weapon(stinger_minigun, primary), weapon(shock_rifle, primary)]) ;
					(Range = "long", WeaponList = [weapon(stinger_minigun, primary), weapon(shock_rifle, primary)]).

%% *********************
%% ** END ALL MODULES **
%% *********************

%% *************************
%% ** BGN getWeapon.mod2g **
%% *************************

	
% weapon priority list, contains hardList without worse weapons then the ones in inventory.
% Input requirement: insert hardList to start. List is output.
priorities([HH|HT], Wep) :-Wep = HH;
                           (
                           not(weapon(HH,_,_)),
                           priorities(HT,Wep)
                           ).
priorities([],_).

% Hardcode base priorities list. 
hardList(List) :- List = [flak, stinger, linkgun, shockrifle, rocketlauncher, biorifle, sniperrifle].

% gives true if want weapon.
wantWep(Weapon) :- hardList(HARD),
                   priorities(HARD, Weapon),
                   member(Weapon, HARD),
                   not(weapon(Weapon,_,_)).

% getWep(Type) is true if it is in inventory.
% getWep(Weapon) :- (weapon(Weapon,_,_)).

% Get a weapon. We are at a certain location if the locations match.
getWep(Location) :- navigation(reached, Location).

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
		
% Get some armor. We are at a certain location if the locations match.
armor(Location) :- navigation(reached, Location).

%% *************************
%% ** END getArmour.mod2g **
%% *************************

%% *************************
%% ** BGN getHealth.mod2g **
%% *************************

% Go get health to heal. We are at a certain location if the locations match.
heal(Location) :- navigation(reached, Location).

%% *************************
%% ** END getHealth.mod2g **
%% *************************

%% *************************
%% ** BGN getAmmo.mod2g **
%% *************************

% Get extra ammo when needed. We are at a certain location if the locations match.
ammo(Location) :- navigation(reached, Location).

%% *************************
%% ** END getAmmo.mod2g **
%% *************************

%% ***********************
%% ** BGN Carrier.mod2g **
%% ***********************

% Calculate the length of a path from starting point to end point
calculatePath(StartID, EndID) :- path(StartID, EndID, _, _).

% Take the flag from the component. We are at a certain location if the IDs match.
takeFlag(UnrealID) :- flag(Team, HolderID, _), myTeam(MyTeam), not(MyTeam = Team), self(HolderID, _, _).

% Pick up our flag of the ground. We are at a certain location if the IDs match.
pickUpFlag(UnrealID) :- navigation(reached, UnrealID).
	
% Bring the flag back home to our base. We are at a certain location if the IDs match.
bringBackFlag(UnrealID) :- flag(Team, HolderID, _), myTeam(MyTeam), not(MyTeam = Team), not(self(HolderID, _, _)).

%!!!!!!!!!!!!!!!!!!!!!!!!!%
% TEMPORARY GOAL (will be replaced for modules getHealth and getWeapon). Grab closeby stuff. We are at a certain location if the IDs match.
grabStuff(UnrealID) :- navigation(reached, UnrealID).
	
%% ***********************
%% ** END Carrier.mod2g **
%% ***********************

%% ************************
%% ** BGN Defender.mod2g **
%% ************************
		
% Go to a destination. We are at a certain location if the IDs match.
goTo(UnrealID) :- navigation(reached, UnrealID).
		
%% ************************
%% ** END Defender.mod2g **
%% ************************

%% **********************
%% ** BGN Roamer.mod2g **
%% **********************

% get weapon inventory in list form.
wepList(List) :- weapon(X,_,_),	member(X, List).

%% **********************
%% ** END Roamer.mod2g **
%% **********************

%% *************************
%% ** BGN killEnemy.mod2g **
%% *************************

% spin in a round.
rotate(A,C,B) :- orientation(A, _, _), 
					A = location(X, Y, Z),
					B = location( (X + cos(C + (pi/2))), Y, (Z + sin(C + (pi/2)))).
					
%% *************************
%% ** END killEnemy.mod2g **
%% *************************
