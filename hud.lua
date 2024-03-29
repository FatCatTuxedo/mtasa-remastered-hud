local WeaponShouldBeShownIfAmmo = {
    [16] = true, [17] = true, [18] = true, [19] = true,
    [22] = true, [23] = true, [24] = true, [25] = true, [26] = true, [27] = true, [28] = true, [29] = true,
    [30] = true, [31] = true, [32] = true, [33] = true, [34] = true, [35] = true, [36] = true, [37] = true, [38] = true, [39] = true,
    [41] = true, [42] = true, [43] = true,
}

local screenWidth, screenHeight = guiGetScreenSize()

local weaponImages = {}
for i = 0, 45 do
    weaponImages[i] = "icons/".. i ..".png"
end


local function disableHud() 
    setPlayerHudComponentVisible( "all", false)
    setPlayerHudComponentVisible( "radar", true)
    setPlayerHudComponentVisible( "crosshair", true)
end
    
local function enableHud() 
    setPlayerHudComponentVisible( "all", true)
end

addEventHandler("onClientResourceStart", root, disableHud)
addEventHandler("onClientPlayerJoin", root, disableHud)
addEventHandler("onClientResourceStop", root, enableHud)




-- showing new hud
function displayHUD()
    -- data collection
    local weaponType = getPedWeapon(localPlayer)
    local money = getPlayerMoney()
    local hour, minute = getTime()
    local health = getElementHealth(localPlayer)
    local armor = getPedArmor(localPlayer)
    local ammo = getPedTotalAmmo(localPlayer)
    local ammoClip = getPedAmmoInClip(localPlayer)
    
    -- data formatting
    local healthFormatted = string.format("%6.0f", health)
    local healthWidth = (tonumber(healthFormatted) / 100) * 200
    local armorFormatted = string.format("%6.0f", g_armor)
    local armorWidth = (tonumber(armorFormatted) / 100) * 211
    local moneyFormatted = string.format("%08d", money)
    minute = string.format("%02d", minute)

    if weaponType then
        dxDrawImage(1555, 100, 126, 126, weaponImages[weaponType], 0, 0, 0, 0xFFFEFEFE, false)
    end

    dxDrawText(hour ..":".. minute, 1690 - 4, 150 - 4, 1782 - 4, 168 - 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(hour ..":".. minute, 1690 + 4, 150 - 4, 1782 + 4, 168 - 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(hour ..":".. minute, 1690 - 4, 150 + 4, 1782 - 4, 168 + 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(hour ..":".. minute, 1690 + 4, 150 + 4, 1782 + 4, 168 + 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(hour ..":".. minute, 1690, 150, 1782, 168, 0xFFFFFFFF, 2.00, "pricedown", "center", "center", false, false, false, false, false)

    dxDrawRectangle(1608-28, 224, 208, 24, tocolor(3, 0, 0, 254), false) -- health bar
    dxDrawRectangle(1612-28, 228, healthWidth, 16, tocolor(223, 0, 0, 254), false) -- health
    dxDrawRectangle(1612-28, 228, 200, 16, tocolor(223, 0, 0, 150), false) -- health shadow

    if armor > 0 then
        dxDrawRectangle(1608+72, 190, 108, 24, tocolor(3, 0, 0, 254), false) -- armor bar
        dxDrawRectangle(1612+72, 194, 100, 16, tocolor(230, 249, 249, 150), false) -- armor shadow
        dxDrawRectangle(1612+72, 194, g_armor, 16, tocolor(254, 249, 249, 255), false) -- armor

    end

    if WeaponShouldBeShownIfAmmo[weaponType] then
        dxDrawText(ammoClip .."/".. ammo, 1572 - 1, 202 - 1, 1657 - 1, 220 - 1, 0xFF000000, 1.40, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(ammoClip .."/".. ammo, 1572 + 1, 202 - 1, 1657 + 1, 220 - 1, 0xFF000000, 1.40, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(ammoClip .."/".. ammo, 1572 - 1, 202 + 1, 1657 - 1, 220 + 1, 0xFF000000, 1.40, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(ammoClip .."/".. ammo, 1572 + 1, 202 + 1, 1657 + 1, 220 + 1, 0xFF000000, 1.40, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(ammoClip .."/".. ammo, 1572, 202, 1657, 220, 0xFFBBD6FF, 1.40, "default-bold", "center", "center", false, false, false, false, false)
    end

    if money < 0 then
        dxDrawText("$".. g_pmoney, 1552 - 4, 262 - 4, 1788 - 4, 302 - 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552 + 4, 262 - 4, 1788 + 4, 302 - 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552 - 4, 262 + 4, 1788 - 4, 302 + 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552 + 4, 262 + 4, 1788 + 4, 302 + 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552, 262, 1788, 302, 0xFFFF0000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
    else
        dxDrawText("$".. g_pmoney, 1552 - 4, 262 - 4, 1788 - 4, 302 - 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552 + 4, 262 - 4, 1788 + 4, 302 - 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552 - 4, 262 + 4, 1788 - 4, 302 + 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552 + 4, 262 + 4, 1788 + 4, 302 + 4, 0xFF000000, 2.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("$".. g_pmoney, 1552, 262, 1788, 302, 0xFF246100, 2.00, "pricedown", "center", "center", false, false, false, false, false)
    end

end
addEventHandler("onClientRender", root, displayHUD)
