local colorline_frame = Color( 255, 255, 255, 100 )
local colorbg_frame = Color(52, 55, 64, 200)

local good_responses = 0
local function CheckOnline()
    http.Fetch("http://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001?addr=" .. game.GetIPAddress(), function(data)
        data = util.JSONToTable(data)
        if not data and not data.servers and not data.servers[1] then
            good_responses = 0
            return
        end
        if good_responses < 10 then
            good_responses = good_responses + 1
        else
            LocalPlayer():ConCommand("connect " .. game.GetIPAddress())
        end
    end)
end

local function open_changegamemode_screen()
	if ValidPanel(pnl) then pnl:Remove() end
    
	local pnl = vgui.Create("DFrame")
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:SetSize(ScrW(), ScrH())
	pnl:SetMouseInputEnabled(true)
	pnl:SetAlpha(0) 
	pnl:AlphaTo(255, .5)
	pnl:MakePopup()
	function pnl:Close()
		pnl:SetKeyboardInputEnabled(false) 
		pnl:SetMouseInputEnabled(false)
		pnl:AlphaTo(0, .5, 0, function() pnl:Remove() end)
	end
	function pnl:Think()
		CheckOnline()
	end
	pnl.Paint = function(self, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg_frame )
		surface.SetDrawColor( colorline_frame )
        surface.DrawOutlinedRect( 0, 0, w , h )
    end
    
	local center_lbl = pnl:Add("DLabel")
	center_lbl:SetText(GamemodeChange.Config.textmenu)
    center_lbl:SetContentAlignment(5) 
    center_lbl:SetSize(ScrW(), 100)
    center_lbl:SetFont("DermaLarge")
    center_lbl:Center()
    center_lbl:SetTextColor(color_white) 
end
concommand.Add("numerix_test2", function() open_changegamemode_screen() end)


net.Receive("Numerix:OpenRestartMenu", function()
	open_changegamemode_screen()
end)
