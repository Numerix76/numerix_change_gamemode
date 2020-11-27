GamemodeChange = GamemodeChange or {}
GamemodeChange.Config = GamemodeChange.Config or {}

--Client ID mTxServ
GamemodeChange.Config.client_id = ""

--Client Secret mTxServ
GamemodeChange.Config.client_secret = ""

--API Key mTxServ
GamemodeChange.Config.api_key = ""

--ServerID présent dans l'url mTxServ
GamemodeChange.Config.ServerID = ""

--Message sur le menu d'attente
GamemodeChange.Config.textmenu = "Le serveur change de gamemode. Veuillez patientez."
 
--Ne toucher pas sauf si vous savez ce que vous faîtes
GamemodeChange.Config.TableOfHook = {
    ["deathrun"] = "DeathrunBeginOver",
    ["murder"] = "OnEndRound",
    ["trashcompactor"] = "OnRoundFinish",
    ["sledbuild"] = "OnRoundFinish",
    ["extremefootballthrowdown"] = "OnRoundFinish",
    ["slasher"] = "sls_round_End",
    ["psw2"] = "OnRoundFinish",
    ["prop_hunt"] = "RoundEnd",
    ["nzombies"] = "OnRoundEnd",
    ["guesswho"] = "GWOnRoundEnd",
    ["tfil"] = "Lava.PostRound",
}
