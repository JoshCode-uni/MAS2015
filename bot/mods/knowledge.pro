%% *************************
%% ** BGN getWeapon.mod2g **
%% *************************
	
	% [PlaceHolder] weapon/3 initiator to correct weird GOAL behaviour.
	weapon(none,none,none).
	
	% [PlaceHolder] item/4 initiator to correct weird GOAL behaviour.
	item(none,none,none,none).
	
	% weapon priority list, contains hardList without worse weapons then the ones in inventory.
	% Input requirement: insert hardList to start. List is output.
	priorities(List, Hlist) :- Hlist = [HH|TH],
				((not(weapon(HH,_,_),
				priorities([HH|List], TH));
				(weapon(HH,_,_),
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
