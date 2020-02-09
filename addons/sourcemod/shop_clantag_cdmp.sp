#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Oylsister"
#define PLUGIN_VERSION "1.0.0"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <shop>
#include <clientprefs>

#include <autoexecconfig>

char ClanTag[512];

ConVar	g_hClanTag;
ConVar	g_hClanTagMulti;

float ClantagMulti;

public Plugin myinfo = 
{
	name = "[Shop] ClanTag Credits Multiplier",
	author = PLUGIN_AUTHOR,
	description = "Set Credits Multiplier  for Using Clantag",
	version = PLUGIN_VERSION,
	url = "https://github.com/oylsister/-Shop-Clantag-Credits-Multiplier"
};

public OnPluginStart()
{
	CreateConVar("sm_shop_cdmp_version", PLUGIN_VERSION, "Credits Multiplier Version", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY|FCVAR_CHEAT|FCVAR_DONTRECORD);
	g_hClanTag = CreateConVar("sm_shop_cdmp_clantag", "[SM]", "The Clantag that used for credits multiplier .");
	g_hClanTagMulti = CreateConVar("sm_shop_cdmp_clantag_mutil", "1.3", "How much you want to mutilply with credits.", 0, true, 1.0, false);
	
	AutoExecConfig(true, "shop_clantag_credits_mulitplier");
}

public void OnMapStart()
{
	g_hClanTag.GetString(ClanTag, sizeof(ClanTag));
	ClantagMulti = g_hClanTagMulti.FloatValue;
}

public Action Shop_OnCreditsGiven(client, &credits, by_who)
{
	if((by_who == CREDITS_BY_NATIVE || by_who == CREDITS_BY_COMMAND))
	{
		char clanTag[16];
		CS_GetClientClanTag(client, clanTag, 16);
		if(StrEqual(clanTag, ClanTag, false))
		{
			credits = RoundToCeil(float(credits) * ClantagMulti);
		}
		return Plugin_Changed;
	}
	return Plugin_Continue;
}




