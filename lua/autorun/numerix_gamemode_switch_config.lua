GamemodeChange = GamemodeChange or {}
GamemodeChange.Config = GamemodeChange.Config or {}

--Client ID mTxServ (https://mtxserv.com/fr/mon-compte/oauth
GamemodeChange.Config.client_id = ""

--Client Secret mTxServ (https://mtxserv.com/fr/mon-compte/oauth)
GamemodeChange.Config.client_secret = ""

--API Key mTxServ (https://mtxserv.com/fr/mon-compte/api)
GamemodeChange.Config.api_key = ""

--ServerID mTxServ (nombre après le # sous l'adresse IP. Ex : GMod 8 slots #148713 le code sera 148713)
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
