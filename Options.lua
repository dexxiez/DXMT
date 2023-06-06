DXMT = LibStub("AceAddon-3.0"):GetAddon("DXMT");

local defaults = {
	profile = {
		interruptsEnabled = true,
	},
}

local options = { 
	name = "Dexxiez Mandatory Toolkit",
	handler = DXMT,
	type = "group",
	args = {
        interruptsEnabled = {
                        type = "toggle",
                        name = "Click if gay",
                        desc = "Toggles being gay",
                        get = function (info) return self.interruptsEnabled end,
                        set = "ToggleGay"
                    },
		-- betterGroup = {
        --     name = "Interrupts",
        --     handler = DXMT,
        --     type = "group",
        --     args = {
        --         clickIfGay = {
        --             type = "toggle",
        --             name = "Click if gay",
        --             desc = "Toggles being gay",
        --             get = "GetIsGay",
        --             set = "ToggleGay"
        --         },
        --     },
        -- },
	},
}

function DXMT:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("DXMT", options);
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DXMT", "DXMT");
    -- default values
	self.interruptsEnabled = true;
    self.isGay = true;
end