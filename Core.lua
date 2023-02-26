DXMT = LibStub("AceAddon-3.0"):NewAddon("DXMT", "AceConsole-3.0", "AceEvent-3.0")

local defaults = {
	profile = {
		interruptsEnabled = true,
        interruptsMode = 'GOOD_MODE'
	},
}

local options = { 
	name = "Dexxiez Mandatory Toolkit",
	handler = DXMT,
	type = "group",
	args = {
        interruptsEnabled = {
            type = "toggle",
            order = 0,
            name = "Interrupts Enabled",
            desc = "If you turn this off you're gay",
            get = "GetInteruptsEnabled",
            set = "SetInteruptsEnabled"
        },
        interruptsMode = {
            type = "select",
            order = 1,
            name = "Interrupt Mode",
            values = {
                ["GOOD_MODE"] = "GOOD MODE",
                ["NOT_GOOD_MODE"] = "NOT GOOD MODE",
                ["TERRIBLE_MODE"] = "TERRIBLE MODE"
            },
            get = "GetInterruptsMode",
            set = "SetInterruptsMode"
        }
	},
}

function DXMT:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DXMTDB", defaults, true);
	LibStub("AceConfig-3.0"):RegisterOptionsTable("DXMT", options);
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DXMT", "DXMT");
	self:RegisterChatCommand("DXMT", "SlashCommand");
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end

function DXMT:OnEnable()
	-- Chilling
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

-- Getters and Setters
function DXMT:GetInteruptsEnabled(info)
    return self.db.profile.interruptsEnabled;
end

function DXMT:SetInteruptsEnabled(info, value)
    self.db.profile.interruptsEnabled = value;
end

function DXMT:GetInterruptsMode(info)
    return self.db.profile.interruptsMode;
end

function DXMT:SetInterruptsMode(info, value)
    self.db.profile.interruptsMode = value;
end