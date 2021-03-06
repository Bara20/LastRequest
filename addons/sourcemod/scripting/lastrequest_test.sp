#pragma semicolon 1

#include <sourcemod>

#pragma newdecls required

#include <lastrequest>

#define LR_NAME "Test"
#define LR_SHORT "test"

public Plugin myinfo =
{
    name = LR_PLUGIN_NAME ... LR_NAME,
    author = "Bara",
    description = "",
    version = "1.0.0",
    url = "github.com/Bara"
};

public void OnConfigsExecuted()
{
    if (!LR_RegisterGame(LR_SHORT, LR_NAME, OnGamePreStart, OnGameStart, OnGameEnd))
    {
        SetFailState("Can't register last request: %s", LR_SHORT);
    }
}

public void LR_OnOpenMenu(Menu menu)
{
    PrintToChatAll("(LR_OnOpenMenu) called!");
    
    menu.AddItem(LR_SHORT, "Test");
}

public bool LR_OnLastRequestAvailable(int client)
{
    if(LR_IsLastRequestAvailable())
    {
        PrintToChatAll("Last request is now available!");
        PrintToChatAll("Last T is: %N", client);
    }
    PrintToChatAll("(LR_OnLastRequestAvailable) called!");
}

public Action OnGamePreStart(int requester, int opponent, const char[] shortname)
{
    PrintToChatAll("(OnGamePreStart) called!");
    PrintToChatAll("OnGamePreStart - Requester: %d, Opponent: %d, Shot Name: %s", requester, opponent, shortname);

    LR_StartLastRequest(requester, "Test", "All Weapons", 100, false);
}

public void OnGameStart(int requester, int opponent, const char[] shortname)
{
    PrintToChatAll("(OnGameStart) called!");
    PrintToChatAll("OnGameStart - Requester: %d, Opponent: %d, Shot Name: %s", requester, opponent, shortname);
}

public void OnGameEnd(LR_End_Reason reason, int winner, int loser)
{
    PrintToChatAll("(OnGameEnd) called!");
    PrintToChatAll("OnGameEnd - Reason: %d, Winner: %d, Loser: %d", reason, winner, loser);
}
