DXMT = LibStub("AceAddon-3.0"):NewAddon("DXMT", "AceConsole-3.0", "AceEvent-3.0")

local defaults = {
	profile = {
		message = "Gay if default",
		isGay = true,
	},
}

local options = { 
	name = "Dexxiez Mandatory Toolkit",
	handler = DXMT,
	type = "group",
	args = {
		betterGroup = {
            name = "Cool Checkboxes",
            handler = DXMT,
            type = "group",
            args = {
                clickIfGay = {
                    type = "toggle",
                    name = "Click if gay",
                    desc = "Toggles being gay",
                    get = "GetIsGay",
                    set = "ToggleGay"
                },
            },
        },
	},
}

function DXMT:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DXMTDB", defaults, true);
	LibStub("AceConfig-3.0"):RegisterOptionsTable("DXMT", options);
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DXMT", "DXMT");
	self:RegisterChatCommand("DXMT", "SlashCommand");
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    -- default values
	self.message = "Gay if type";
    self.isGay = true;
end

function DXMT:OnEnable()
	
end

function DXMT:SlashCommand(msg)
    if not msg or msg:trim() == "" then
		-- https://github.com/Stanzilla/WoWUIBugs/issues/89
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame);
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame);
        return;
    end
	if msg == "que" then
        local count = 0
        for _ in pairs(DXMT:GetNPCs()) do count = count + 1 end
        print(count);
        return;
    end
end


function DXMT:GetMessage(info)
	return self.message;
end

function DXMT:SetMessage(info, value)
	self.message = value;
end

function DXMT:GetIsGay(info)
    return self.isGay;
end

function DXMT:ToggleGay(info, value)
    self.isGay = value;
end