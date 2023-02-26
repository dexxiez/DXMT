DXMT = LibStub("AceAddon-3.0"):GetAddon("DXMT");

local SPELLS_MD = {
    34477,
    57934,
    42833
}

local scanTool = CreateFrame( "GameTooltip", "ScanTooltip", nil, "GameTooltipTemplate" );
scanTool:SetOwner( WorldFrame, "ANCHOR_NONE" );
local scanText = _G["ScanTooltipTextLeft2"];

local function getPetOwner(petName)
    scanTool:ClearLines();
    scanTool:SetUnit(petName);
    local ownerText = scanText:GetText();
    if not ownerText then return nil end
    local owner, _ = string.split("'",ownerText);
    
    return owner -- This is the pet's owner
 end

local function getSpell()
    local spell = GetSpellLink(math.random(11739, 62358));
    if (spell ~= nil and spell ~= '') then
        return spell;
    end
    getSpell();
end

local function getInterruptMessage(src, dest, spellId)
    local npcs = DXMT:GetNPCs();
    if(DXMT.db.profile.interruptsMode == "TERRIBLE_MODE") then
        return src .. " interupted ".. dest .. "'s " .. GetSpellLink(spellId);
    elseif (DXMT.db.profile.interruptsMode == "NOT_GOOD_MODE") then
        return src .. " interupted ".. dest .. "'s " .. getSpell();
    else
        return src .. " interupted ".. npcs[math.random(1, table.getn(npcs))] .. "'s " .. getSpell();
    end
end

function DXMT:COMBAT_LOG_EVENT_UNFILTERED(self, event)
    
    if(not DXMT.db.profile.interruptsEnabled) then return end;
    if(not IsInInstance()) then return end;

    local _, subevent, _, sourceGUID, sourceName, _, _, _, destName = CombatLogGetCurrentEventInfo();
    -- if subevent == "SPELL_CAST_SUCCESS" then
    --     if(destName ~= nil and destName ~= '') then
    --         print(sourceName .. " is gay for " .. destName);
    --     end
    -- end
    if subevent == "SPELL_INTERRUPT" then 
        local spellId = select(12, CombatLogGetCurrentEventInfo());

        -- Flame Jets
        if(spellId == 62681) then
            if(UnitInRaid("player")) then
                SendChatMessage(destName .. " FAILED THE {star}APTITUDE TEST{star}", "RAID");
                return;
            end

            if(UnitInRaid("player")) then
                SendChatMessage(destName .. " FAILED THE {star}APTITUDE TEST{star}", "RAID");
                return;
            end
            return;
        end

        if(string.find(sourceGUID, "Player-" or string.find(sourceGUID, "Pet-"))) then
            local src = sourceName;
            if(string.find(sourceGUID, "Pet-")) then
                src = getPetOwner(sourceName);
            end
            
            if(UnitInParty("player")) then
                SendChatMessage(getInterruptMessage(src, destName, spellId), "PARTY");
                return;
            end

            if(UnitInRaid("player")) then
                SendChatMessage(getInterruptMessage(src, destName, spellId), "RAID");
                return;
            end
            
        end
    end
end


