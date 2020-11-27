GamemodeChange = GamemodeChange or {}
GamemodeChange.Config = GamemodeChange.Config or {}

--Client ID mTxServ
GamemodeChange.Config.client_id = "804_1ux3ppff4ly8g4gsgk8kckk00so40g4ckk0k4wsogsssg4sk8s"

--Client Secret mTxServ
GamemodeChange.Config.client_secret = "4fjuso5ppx4wksgg408cc8ocwk08s84s08oo08gkgokkc4kkg8"

--API Key mTxServ
GamemodeChange.Config.api_key = "GhYlGqsWLYJsJ5jpoysdkbxsBr3GktRTUS0IZ1PtYyUtDkI8ua"

--ServerID présent dans l'url mTxServ
GamemodeChange.Config.ServerID = "148713"

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