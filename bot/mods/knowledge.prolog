%% ***************************
%% ** BGN GENERAL KNOWLEDGE **
%% ***************************

% We are at a certain location if the IDs match, or ...
at(UnrealID) :- navigation(reached, UnrealID).
% if the coordinates are approximately equal.
at(location(X, Y, Z)) :- navigation(reached, location(X1, Y1, Z1)), 
	round(X) =:= round(X1), round(Y) =:= round(Y1), round(Z) =:= round(Z1).

% myTeam(?Team).
% Gives the string of our team, eg. 'red' or 'blue'
myTeam(Team) :- self(_,_,Team).
% theirTeam(?Team).
% Gives the string of the enemy's team, eg. 'red' or 'blue'
theirTeam(TheirTeam) :- myTeam(Team), base(TheirTeam, BaseID), myBase(MyBase), not(BaseID = MyBase).

% myBase(?BaseID).
% Gives the UnrealID of the our team's base
myBase(BaseID) :- myTeam(Team), base(Team, BaseID).
% theirBase(?BaseID).
% Gives the UnrealID of the enemy's base
theirBase(BaseID) :- myTeam(Team), base(TheirTeam, BaseID), not(Team = TheirTeam).

% enemy(+UnrealID).
% Returns true if the UnrealID is an enemy
enemy(UnrealID) :- theirTeam(EnemyTeam), bot(UnrealID, _, EnemyTeam, _, _, _).

iHaveFlag :- self(MyID, _, _), flag(Team, MyID, _), myTeam(MyTeam), not(MyTeam = Team).

% Prefer these weapons given the range to enemy.
preferedWeapons(WeaponList, Range) :- (Range = "short", WeaponList = [weapon(link_gun, primary), weapon(flak_cannon, primary), weapon(stinger_minigun, primary)]) ;
					(Range = "mid", WeaponList = [weapon(flak_cannon, primary), weapon(stinger_minigun, primary), weapon(shock_rifle, primary)]) ;
					(Range = "long", WeaponList = [weapon(stinger_minigun, primary), weapon(shock_rifle, primary)]).

%% ***************************
%% ** BGN GENERAL KNOWLEDGE **
%% ***************************

%% *************************
%% ** BGN getWeapon.mod2g **
%% *************************

% weapon priority list, contains hardList without worse weapons then the ones in inventory.
% Input requirement: insert hardList to start. List is output.
% priorities(+List, -Weapon).
priorities([HH|HT], Wep) :- Wep = HH ; (not(weapon(HH, _, _)), priorities(HT,Wep)).
priorities([],_).

% Hardcode base priorities list. 
hardList(List) :- List = [flak_cannon, stinger_minigun, link_gun, shock_rifle, rocket_launcher, bio_rifle, sniper_rifle].

% gives true if want weapon.
wantWep(Weapon) :- hardList(HARD),
                   priorities(HARD, Weapon),
                   member(Weapon, HARD),
                   not(weapon(Weapon,_,_)).

% getWep(Type) is true if it is in inventory.
getWep(Weapon) :- navigation(reached, Location).

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

%% **************************
%% ** BGN getPowerUp.mod2g **
%% **************************

% Go get powerups. We are at a certain location if the locations match.
getPowerUp(Location) :- navigation(reached, Location).

%% **************************
%% ** END getPowerUp.mod2g **
%% **************************

%% ***********************
%% ** BGN getAmmo.mod2g **
%% ***********************

% Get extra ammo when needed. We are at a certain location if the locations match.
ammo(Location) :- navigation(reached, Location).

%% ***********************
%% ** END getAmmo.mod2g **
%% ***********************

%% ***********************
%% ** BGN Carrier.mod2g **
%% ***********************

% Calculate the length of a path from starting point to end point
calculatePath(StartID, EndID) :- path(StartID, EndID, _, _).

% Take the flag from the component. True when bot holds the other team's flag.
captureFlag(_) :- flag(Team, HolderID, _), myTeam(MyTeam), not(MyTeam = Team), self(HolderID, _, _).

% Pick up our flag of the ground. True when bot holds our flag.
returnFlag(_) :- flag(Team, HolderID, _), myTeam(MyTeam), MyTeam = Team, self(HolderID, _, _).
	
% Bring other team's flag to our base. True when other team's flag is back at home.
deliverFlag(_) :- flag(Team, HolderID, _), myTeam(MyTeam), not(MyTeam = Team), not(self(HolderID, _, _)).
	
%% ***********************
%% ** END Carrier.mod2g **
%% ***********************

%% ************************
%% ** BGN Defender.mod2g **
%% ************************
		
% Go to a destination. We are at a certain location if the IDs match.
goTo(UnrealID) :- navigation(reached, UnrealID).

% Can be used to calculate the distance between (X1,Y1) and (X2,Y2), as of yet, it gives the SQUARED distance.
distance(Dist,X1,Y1,X2,Y2) :- Distance is (X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2), Dist is sqrt(Distance).

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

follow(UnrealID) :- navigation(reached,UnrealID); fragged(_,_,UnrealID,_); not(bot(UnrealID, _, _, _, _, _)).

% Spin around.
% Rotate(+Location, +Angle, -LookLocation)
rotate(Location, Angle, LookLocation) :- LookLocation is 0.
					
%% *************************
%% ** END killEnemy.mod2g **
%% *************************
