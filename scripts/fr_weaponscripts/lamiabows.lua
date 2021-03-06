--[[
Arg structure:

No args for this one. Not yet, anyway.

ONLY run in bows! Or something else that has firePosition and aimVector methods
]]

function FRHelper:call()
    local energyValue = status.resource("energy") or 100

    -- 10% chance of random projectile
    if math.random(10) == 1	then
        local attackType = math.random(6)
        if (attackType) == 1 and (energyValue) >= 100 then
            params = { power = energyValue/10 , damageKind = "shadow", speed = 45, timeToLive = 3 }
            projectileId = world.spawnProjectile("purplearrow",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        elseif (attackType) == 2 and (energyValue) >= 100 then
            params = { power = energyValue/12 , damageKind = "shadow", speed = 60, timeToLive = 3 }
            projectileId = world.spawnProjectile("chargedpurplearrow",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        elseif (attackType) == 3 and (energyValue) >= 100 then
            params = { power = energyValue/12 , damageKind = "shadow", speed = 30, timeToLive = 1 }
            projectileId = world.spawnProjectile("magentaglobelamia",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        elseif (attackType) == 4 and (energyValue) >= 100 then
            params = { power = energyValue/12 , damageKind = "poison", speed = 50, timeToLive = 1 }
            projectileId = world.spawnProjectile("poisonplasma",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        elseif (attackType) == 5 and (energyValue) >= 100 then
            params = { power = energyValue/12 , damageKind = "shadow", speed = 50, timeToLive = 1 }
            projectileId = world.spawnProjectile("ngravitybolt",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        elseif (attackType) == 6 and (energyValue) >= 100 then
            params = { power = energyValue/12 , damageKind = "shadow", speed = 30, timeToLive = 1 }
            projectileId = world.spawnProjectile("orangeglobelamia",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        else
            params = { power = energyValue/12 , damageKind = "shadow", speed = energyValue/3, timeToLive = 3 }
            projectileId = world.spawnProjectile("purplearrow",self.script_params:firePosition(),activeItem.ownerEntityId(),self.script_params:aimVector(),false,params)
        end
    end

    -- Energy and luck based crit chance bonus
    local randValueCritBonus = math.random(4)
    local critValueLamia = ( randValueCritBonus + math.ceil(energyValue/40) )
    if energyValue >= (status.stat("maxEnergy")*0.5) then	-- with high Energy reserve, lamia get increased Bow crit chance
        status.modifyResource("energy", (energyValue * -0.01) )	-- consume energy
        applyStats({stats={
            {stat = "critChance", amount = critValueLamia},
            {stat = "powerMultiplier", baseMultiplier = 1 + (critValueLamia/100) * 2}
        }}, "lamiabowbonus")
    end
end
