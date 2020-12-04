-- include("lua/autorun/numerix_gamemode_switch_config.lua")
-- AddCSLuaFile("lua/autorun/numerix_gamemode_switch_config.lua")

local apiURL_Token = 'https://mtxserv.com/oauth/v2/token'
local apiURL_Gamemode = "https://gmod-radio-numerix.mtxserv.com/changegamemode_api/changegamemode.php"
local apiURL_Collection = "https://gmod-radio-numerix.mtxserv.com/changegamemode_api/changecollection.php"
local apiURL_MapStart = "https://gmod-radio-numerix.mtxserv.com/changegamemode_api/changemap.php"
local apiURL_Restart = "https://gmod-radio-numerix.mtxserv.com/changegamemode_api/restart.php"

util.AddNetworkString("Numerix:OpenRestartMenu") 
local function Restart(token)
    for k, ply in ipairs(player.GetAll()) do
        ply:ChatPrint("Le serveur va changer de gamemode dans 5 secondes.")
    end
 
    MsgC("Le serveur va changer de gamemode dans 5 secondes.")

    net.Start("Numerix:OpenRestartMenu")
    net.Broadcast()
 
    http.Fetch(apiURL_Restart.."?access_token="..token.."&serverid="..GamemodeChange.Config.ServerID, 
        function(body)
            if body == "" then 
                print("Restart en cours")
            else
                print("Erreur lors du restart : "..body)
            end
        end, 
        function(error) 
            print("Erreur lors du restart : "..error)
        end
    )
 
end
 
local function ChangeMap(token, map)
    http.Fetch(apiURL_MapStart.."?access_token="..token.."&map="..map.."&serverid="..GamemodeChange.Config.ServerID,
        function(body)
            if body == "" then 
                print("Changement de map avec succès")
            else
                print("Erreur lors du changement de map : "..body)
            end
        end, 
        function(error) 
            print("Erreur lors du changement de map : "..error)
        end
    )
end
 
local function ChangeGamemode(token, gamemode)
    http.Fetch(apiURL_Gamemode.."?access_token="..token.."&gamemode="..gamemode.."&serverid="..GamemodeChange.Config.ServerID, 
        function(body)
            if body == "" then 
                print("Changement de gamemode avec succès")
            else
                print("Erreur lors du changement de gamemode : "..body)
            end
        end, 
        function(error) 
            print("Erreur lors du changement de gamemode : "..error)
        end
    )
end
 
local function ChangeCollection(token, collection)
    http.Fetch(apiURL_Collection.."?access_token="..token.."&collection="..collection.."&serverid="..GamemodeChange.Config.ServerID, 
        function(body)
            if body == "" then 
                print("Changement de collection avec succès")
 
                Restart(token)
            else
                print("Erreur lors du changement de collection : "..body)
            end
        end, 
        function(error) 
            print("Erreur lors du changement de collection : "..error)
        end
    )
end

concommand.Add("numerix_changegamemode", function(ply, command, args)
 
    if IsValid(ply) and !ply:IsSuperAdmin() then return end
 
    local map = args[1]
    local gamemode = args[2]
    local collection = args[3]
    local forceround = args[4] or false
 
    if !map or !collection or !gamemode then 
        if IsValid(ply) then
            ply:PrintMessage(HUD_PRINTCONSOLE, "La commande doit être : "..command.." map gamemode collection")
        else
            print("La commande doit être : "..command.." map gamemode collection")
        end
        return
    end
 
    http.Fetch(apiURL_Token.."?client_id="..GamemodeChange.Config.client_id.."&client_secret="..GamemodeChange.Config.client_secret.."&api_key="..GamemodeChange.Config.api_key.."&grant_type=https://mtxserv.com/grants/api_key", 
        function(body)
            local data = util.JSONToTable(body)
            if data["access_token"] then
                if !GamemodeChange.Config.TableOfHook[engine.ActiveGamemode()] or forceround then
                    ChangeMap(data["access_token"], map)
                    ChangeGamemode(data["access_token"], gamemode)
                    ChangeCollection(data["access_token"], collection)
                else
 
                    for k, ply in ipairs(player.GetAll()) do
                        ply:ChatPrint("Le serveur va changer de gamemode à la fin du round.")
                    end
 
                    MsgC("Le serveur va changer de gamemode à la fin du round.")
 
                    local namehook = GamemodeChange.Config.TableOfHook[engine.ActiveGamemode()]
                    hook.Add(namehook, "ChangeGamemode:Jarod:"..namehook, function()
                        ChangeMap(data["access_token"], map)
                        ChangeGamemode(data["access_token"], gamemode)
                        ChangeCollection(data["access_token"], collection)
                    end)
                end
            else
                print("Erreur lors de la récupération du token")
            end
        end, 
        function(error) 
            print("Erreur lors de la récupération du token : "..error) 
        end
    )
end)
 
if engine.ActiveGamemode() == "trashcompactor" then
    local oldRoundEnd = RoundEnd
    function RoundEnd()
        hook.Call("OnRoundFinish")
        oldRoundEnd()
    end
end
 
if engine.ActiveGamemode() == "sledbuild" then
    local oldNewRound = NewRound
    function NewRound() 
        hook.Call("OnRoundFinish")
        oldNewRound()
    end
end
 
if engine.ActiveGamemode() == "extremefootballthrowdown" then
    local oldNewRound = GAMEMODE.NewRound
    function GAMEMODE:OnEndOfGame() 
        hook.Call("OnRoundFinish")
        oldNewRound()
    end
end
 
if engine.ActiveGamemode() == "psw2" then
    local oldNewRound = newRound
    function newRound() 
        hook.Call("OnRoundFinish")
        oldNewRound()
    end
end

if engine.ActiveGamemode() == "minigames" then
    local oldNewRound = SetRound
    function SetRound(round, ...)
        if round == ROUND_ENDING then
            hook.Call("OnRoundFinish")
        end
        oldNewRound(round, ...)
    end
end
