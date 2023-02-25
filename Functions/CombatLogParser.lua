DXMT = LibStub("AceAddon-3.0"):GetAddon("DXMT");
-- COMBAT_LOG_EVENT_UNFILTERED

local SPELLS_MD = {
    34477,
    57934,
    42833
}

local scanTool = CreateFrame( "GameTooltip", "ScanTooltip", nil, "GameTooltipTemplate" );
scanTool:SetOwner( WorldFrame, "ANCHOR_NONE" );
local scanText = _G["ScanTooltipTextLeft2"];

local function getPetOwner(petName)
    scanTool:ClearLines()
    scanTool:SetUnit(petName)
    local ownerText = scanText:GetText()
    if not ownerText then return nil end
    local owner, _ = string.split("'",ownerText)
    
    return owner -- This is the pet's owner
 end

local function getSpell()
    local spell = GetSpellLink(math.random(11739, 62358));
    if (spell ~= nil and spell ~= '') then
        return spell;
    end
    getSpell();
end

function DXMT:COMBAT_LOG_EVENT_UNFILTERED(self, event)
    if(self.isGay) then return end;
    if(not IsInInstance()) then return end;

    local _, subevent, _, sourceGUID, sourceName, _, _, _, destName = CombatLogGetCurrentEventInfo();
    -- if subevent == "SPELL_CAST_SUCCESS" then
    --     if(destName ~= nil and destName ~= '') then
    --         print(sourceName .. " is gay for " .. destName);
    --     end
    -- end

    if subevent == "SPELL_INTERRUPT" then 
        if(string.find(sourceGUID, "Player-" or string.find(sourceGUID, "Pet-"))) then
            local npcs = DXMT:GetNPCs();
            local src = sourceName;
            if(string.find(sourceGUID, "Pet-")) then
                src = getPetOwner(sourceName);
            end
            
            if(UnitInParty("player")) then
                SendChatMessage(src .. " interupted ".. npcs[math.random(1, table.getn(npcs))] .. "'s " .. getSpell(), "PARTY");
            end

            if(UnitInRaid("player")) then
                SendChatMessage(src .. " interupted ".. npcs[math.random(1, table.getn(npcs))] .. "'s " .. getSpell(), "RAID");
            end
            
        end
    end
end


