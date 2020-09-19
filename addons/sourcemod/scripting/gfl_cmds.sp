#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

ConVar g_iServerDiscord = null;

public Plugin myinfo =
{
    name        =    "GFL Server Commands",
    author        =    "Infra",
    description    =    "Essential Chat Commands for GFL Servers.",
    version        =    "1.1",
	url        =    "https://gflclan.com/profile/45876-infra/"
};

public void OnPluginStart()
{
	LoadTranslations("gflcmds.phrases");
	CreateConVar("GFL_Commands_version", "1.1", "GFL Commands Version", FCVAR_DONTRECORD|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	
	g_iServerDiscord = CreateConVar("gfl_server_discord", "0", "Enable/Disable the Discord link command. 1 = Enabled, 0 = Disabled.");
	
	AutoExecConfig(true, "GFL-Commands");
	
	RegConsoleCmd("sm_donate", Command_GFLDonate);
	RegConsoleCmd("sm_perks", Command_GFLPerks);
	RegConsoleCmd("sm_vip", Command_GFLDonate);
	RegConsoleCmd("sm_rules", Command_GFLRules);
	RegConsoleCmd("sm_discord", Command_GFLDiscord);
}

public Action Command_GFLDonate(int client, int args)
{
	ReplyToCommand(client, "\x01[\x0CGFL\x01] \x09Make a donation and avail \x0EVIP\x09 perks on all GFL Servers at\x04 %t", "GFL_Donate");
	return Plugin_Handled;
}

public Action Command_GFLPerks(int client, int args)
{
	ReplyToCommand(client, "\x01[\x0CGFL\x01] \x09Check out all the perks we offer for Members and VIPs at\x04 %t", "GFL_Perks");
	return Plugin_Handled;
}

public Action Command_GFLRules(int client, int args)
{
	ReplyToCommand(client, "\x01[\x0CGFL\x01] \x09You can view the server rules at\x04 %t", "GFL_MOTD");
	return Plugin_Handled;	
}

public Action Command_GFLDiscord(int client, int args)
{
	if(GetConVarInt(g_iServerDiscord) > 0)
	{
		ReplyToCommand(client, "\x01[\x0CGFL\x01] \x09Join our Discord Server!\x04 %t", "GFL_Discord");
		return Plugin_Handled;
	}

	else 
	{
		return Plugin_Handled;
	}
}