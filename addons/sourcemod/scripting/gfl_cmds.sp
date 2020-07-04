#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define PREFIX "\x01[\x0CGFL\x01]"
ConVar g_cServerDiscord = null;
ConVar g_cServerMOTD = null;
ConVar g_cServerGamemode = null;
char g_sServerDiscord[256];
char g_sServerMOTD[256];
char g_sServerGamemode[256];

public Plugin myinfo =
{
    name        =    "GFL Server Commands",
    author        =    "Infra",
    description    =    "Essential Commands for GFL Servers",
    version        =    "1.0",
	url        =    "https://gflclan.com/profile/45876-infra/"
};

public void OnPluginStart()
{
	CreateConVar("GFL_Commands_version", "1.0", "GFL Commands Version", FCVAR_DONTRECORD|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	
	g_cServerGamemode = CreateConVar("gfl_server_gamemode", "", "Specify the name of the gamemode being hosted. Example: Surf Timer, Minigames, etc.");
	GetConVarString(g_cServerGamemode, g_sServerGamemode, 256);
	g_cServerDiscord = CreateConVar("gfl_server_discord", "", "Specify the server's official Discord Server invite link. Set as NONE to disable.");
	GetConVarString(g_cServerDiscord, g_sServerDiscord, 256);
	g_cServerMOTD = CreateConVar("gfl_server_motd", "", "Specify the link to the server's MOTD and Rules on the GFL Forums.");
	GetConVarString(g_cServerMOTD, g_sServerMOTD, 256);
	
	AutoExecConfig(true, "GFL-Commands");
	
	RegConsoleCmd("sm_donate", Command_GFLDonate);
	RegConsoleCmd("sm_vip", Command_GFLDonate);
	RegConsoleCmd("sm_rules", Command_GFLRules);
	RegConsoleCmd("sm_motd", Command_GFLRules);
	RegConsoleCmd("sm_discord", Command_GFLDiscord);
}

public Action Command_GFLDonate(int client, int args)
{
	ReplyToCommand(client, "%s\x09 Make a donation and avail \x0EVIP\x09 perks on all GFL Servers at \x04https://gflclan.com/donate", PREFIX);
	return Plugin_Handled;
}

public Action Command_GFLRules(int client, int args)
{
	ReplyToCommand(client, "%s\x09 You can view the GFL % server rules and MOTD at \x04%s", PREFIX, g_sServerMOTD);
	return Plugin_Handled;	
}

public Action Command_GFLDiscord(int client, int args)
{
	if(!StrEqual(g_sServerDiscord, "NONE"))
	{
		ReplyToCommand(client, "%s\x09 Join the GFL %s Discord Server! \x04%s", PREFIX, g_sServerGamemode, g_sServerDiscord);
		return Plugin_Handled;
	}
}