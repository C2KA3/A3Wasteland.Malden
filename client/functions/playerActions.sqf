// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	["<img image='client\icons\rifle.paa'/> Guardar arma", { player action ["SwitchWeapon", player, player, 100] }, [], 333, false, false, "", "vehicle player == player && currentWeapon player != '' && ( (stance player != 'CROUCH') || (currentWeapon player != handgunWeapon player) )"],
	["<img image='client\icons\rifle.paa'/> Pegar arma Primaria", { player action ["SwitchWeapon", player, player, 0] }, [], -90, false, false, "", "vehicle player == player && currentWeapon player == '' && primaryWeapon player != ''"],

	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[ </t>Player menu<t color='%1'> ]</t>", "#FFFFFF"], "client\systems\playerMenu\init.sqf", [], 444, false], //, false, "", ""],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],

	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3}"],

	["[0]"] call getPushPlaneAction,
	["<img image='client\icons\push.paa'/>Empurrar veiculo", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	["<img image='client\icons\push.paa'/> Empurre o veiculo para a frente", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["<img image='client\icons\push.paa'/> Empurre o veiculo para tras", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],


	["<img image='client\icons\driver.paa'/> Enable driver assist", fn_enableDriverAssist, [], 0.5, false, true, "", "_veh = objectParent player; alive _veh && !alive driver _veh && {effectiveCommander _veh == player && player in [gunner _veh, commander _veh] && {_veh isKindOf _x} count ['LandVehicle','Ship'] > 0 && !(_veh isKindOf 'StaticWeapon')}"],
	["<img image='client\icons\driver.paa'/> Disable driver assist", fn_disableDriverAssist, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {_driver getVariable ['A3W_driverAssistOwner', objNull] == player}"],
	
	["<t color='#FF0000'>Emergency eject</t>",  { [[], fn_emergencyEject] execFSM "call.fsm" }, [], -9, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	["<t color='#FF00FF'>Open magic parachute</t>", A3W_fnc_openParachute, [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 10"],
	
    ["<img image='client\icons\cancel.paa'/> Hide Body", "client\actions\hide.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'Man' && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 2}"],
	["<img image='client\icons\health.paa'/> Heal Self", "client\items\misc\heal.sqf",0,0,false,false,"","(damage player >= 0.02) && (vehicle player == player) && ('FirstAidKit' in items player) || ('Medikit' in items player)"],
	["<img image='addons\spawnBeaconDetector\spawnBeaconDetector.paa'/> Spawn Beacon Detector On", "addons\spawnBeaconDetector\spawnBeaconDetector.sqf",0,-10,false,false,"","('MineDetector' in (items player)) && !spawnBeaconDetectorInProgress && vehicle player == player"],
	["<img image='addons\spawnBeaconDetector\spawnBeaconDetector.paa'/> Spawn Beacon Detector Off", {spawnBeaconDetectorInProgress = false},0,-10,false,false,"","(spawnBeaconDetectorInProgress)"]
];

if (["A3W_vehicleLocking"] call isConfigOn) then
{
	[player, ["<img image='client\icons\r3f_unlock.paa'/> Pick Lock", "addons\scripts\lockPick.sqf", [cursorTarget], 1, false, false, "", "alive cursorTarget && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3 && {{cursorTarget isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorTarget == 2 && !(cursorTarget getVariable ['A3W_lockpickDisabled',false]) && cursorTarget getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"]] call fn_addManagedAction;
};

// Hehehe...
if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Entre como Piloto</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// More Hehehe...
if !(304380 in getDLCs 1) then
{
	[player, ["<img image='client\icons\driver.paa'/> Entre como Piloto", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'B_Heli_Transport_03_F') or (cursorTarget isKindOf 'B_Heli_Transport_03_unarmed_F') or (cursorTarget isKindOf 'Heli_Transport_04_base_F')) && player distance cursorTarget < 10 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<img image='client\icons\gunner.paa'/> Entre como CoPiloto", "client\actions\moveInTurret.sqf", [0], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'B_Heli_Transport_03_F') or (cursorTarget isKindOf 'B_Heli_Transport_03_unarmed_F') or (cursorTarget isKindOf 'Heli_Transport_04_base_F')) && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [0])"]] call fn_addManagedAction;
	[player, ["<img image='client\icons\gunner.paa'/> Entre no artilheiro da porta esquerda", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'B_Heli_Transport_03_F') or (cursorTarget isKindOf 'B_Heli_Transport_03_unarmed_F')) && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<img image='client\icons\gunner.paa'/> Entre no artilheiro da porta Direita", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'B_Heli_Transport_03_F') or (cursorTarget isKindOf 'B_Heli_Transport_03_unarmed_F')) && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
};

// Veiculos Apex Free
if !(395180 in getDLCs 1) then
{
    [player, ["<img image='client\icons\driver.paa'/> Entre como Piloto", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'B_T_VTOL_01_infantry_F') or (cursorTarget isKindOf 'O_T_VTOL_02_infantry_F') or (cursorTarget isKindOf 'B_T_VTOL_01_armed_F') or (cursorTarget isKindOf 'C_Plane_Civil_01_F') or (cursorTarget isKindOf 'B_CTRG_LSV_01_light_F') or (cursorTarget isKindOf 'B_T_LSV_01_unarmed_F') or (cursorTarget isKindOf 'B_T_LSV_01_armed_F') or (cursorTarget isKindOf 'O_T_LSV_02_unarmed_F') or (cursorTarget isKindOf 'O_T_LSV_02_armed_F')) && player distance cursorTarget < 10 && isNull driver cursorTarget"]] call fn_addManagedAction;
    [player, ["<img image='client\icons\gunner.paa'/> Entre como CoPiloto", "client\actions\moveInTurret.sqf", [0], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'C_Plane_Civil_01_F') or (cursorTarget isKindOf 'B_T_VTOL_01_infantry_F') or (cursorTarget isKindOf 'B_T_VTOL_01_armed_F') or (cursorTarget isKindOf 'O_T_VTOL_02_infantry_F')) && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [0])"]] call fn_addManagedAction;
    [player, ["<img image='client\icons\gunner.paa'/> Entre no artilheiro", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'O_T_VTOL_02_infantry_F') or (cursorTarget isKindOf 'O_T_VTOL_02_infantry_F') or (cursorTarget isKindOf 'B_CTRG_LSV_01_light_F') or (cursorTarget isKindOf 'B_T_LSV_01_unarmed_F') or (cursorTarget isKindOf 'B_T_LSV_01_armed_F') or (cursorTarget isKindOf 'O_T_LSV_02_unarmed_F') or (cursorTarget isKindOf 'O_T_LSV_02_armed_F')or (cursorTarget isKindOf 'B_T_VTOL_01_armed_F')) && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<img image='client\icons\gunner.paa'/> Entre no artilheiro 2", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "(locked cursorTarget != 2) && ((cursorTarget isKindOf 'B_T_LSV_01_armed_F') or (cursorTarget isKindOf 'B_T_VTOL_01_armed_F')) && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
};

if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB") then
{
	if (["A3W_vehicleSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { cursorTarget call fn_forceSaveVehicle }, [], -9.5, false, true, "", "call canForceSaveVehicle"]] call fn_addManagedAction;
	};

	if (["A3W_staticWeaponSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Turret", { cursorTarget call fn_forceSaveObject }, [], -9.5, false, true, "", "call canForceSaveStaticWeapon"]] call fn_addManagedAction;
	};
};
