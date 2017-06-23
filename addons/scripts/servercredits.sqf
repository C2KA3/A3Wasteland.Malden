sleep 60;

private ["_messages", "_timeout"];

_messages = [
	["Seja Bem Vindo", (name player)],
	["Crazy To Kill Wasteland Servers", worldName],
	["Nível dos Bots:", "HARDCORE"],
	["Headshot No Revive:", "ATIVADO"],
	["SERVIDOR 64BIT:", "Database: extDB3"],
	["ATM limit max:", "10.000.000"],
	["Objetos e Beacons:", "Ficam salvos por até 7 DIAS"],
	["Veiculos Locados:", "Ficam salvos por até 7 DIAS"],
	["Minas Salvas:", "Ficam salvas por até 7 DIAS"],
	["Mapa", "Malden:"],
    ["REGRAS:", "Discriminação ou preconceito de raça, cor, etnia, religião ou procedência nacional - É Crime!"],
    ["REGRAS:", "É passivo de punição 'BAN' o uso de bots, software de terceiros, bugs, fraude e outras ações desonestas."],
    ["REGRAS:", "Spam 'Propagandas de outros Servidores' Ban permanente"],		
	["Site:", "www.CLANC2K.com.br"],	
	["Teamspeak:", "TS3.CLANC2K.COM.BR"],
	["Doação:", "CLANC2K.com.br/doacao"],
	["Servidor Conect:", "ARMA3.CLANC2K.COM.BR"],
    ["Porta:", "2302"],
    ["Obrigado:", "Ótimo jogo..."]	
	
];

_timeout = 10;
{
	private ["_title", "_content", "_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.35' color='#a81e13' align='left' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.50' color='#FFFFFF' align='left'>%2</t>"), _title, _content];
	[_titleText,[safezoneX + safezoneW - 0.6,0.50],[safezoneY + safezoneH - 0.6,0.7],_timeout,0.5] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;
