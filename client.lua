-------------------
--- BadgerAnims ---
-------------------

--- Config ---

-- Locks for vehicles
enableLockpick = true
enableLock = true
enableUnlock = true
lockpickingCarStr = "Breaking into car"
lockpickingCopCarStr = "Breaking into cop car"
lockpickingCarTime = 10 -- Seconds
lockpickingCopCarTime = 40 -- Seconds
copCars = {
"chgr",
"police",
"police2",
"police3",
"police4",
"police7",
"police8",
"police9",
"police10",
"fbi",
"fbi2",
"unmarked1",
"unmarked2",
"unmarked3",
"unmarked4",
"unmarked5",
"unmarked6",
"unmarked7",
"unmarked8",
"unmarked9",
"silv",
"sheriff2",
"sheriff",
"hwayf150",
"ambulance",
"firetruk",
"pbus",
}

-- Misc
enableHealthInjured = true

-- Walk Styles
enableDrunk = true
enableHiking = true
enableInjured = true
enableMuscleWalk = true

--- Code --
isDrunk = false
if enableDrunk then
	RegisterCommand("drunk", function(source, args, rawCommand)
		if not isDrunk then
			-- Not drunk, give them effects
			if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then
				RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
				while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
					Citizen.Wait(0)
				end
			end

			SetPedIsDrunk(GetPlayerPed(-1), true)
			ShakeGameplayCam("DRUNK_SHAKE", 1.0)
			SetPedConfigFlag(GetPlayerPed(-1), 100, true)
			SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
			DisplayNotification('~r~YoU aRe NoW dRuNk!')
			isDrunk = true
		else
			-- Is drunk, take away effects
			ResetPedMovementClipset(GetPlayerPed(-1))
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMotionBlur(GetPlayerPed(-1), false)
			ShakeGameplayCam("DRUNK_SHAKE", 0.0)
			SetPedConfigFlag(GetPlayerPed(-1), 100, false)
			DisplayNotification('~g~You are now sober!')
			isDrunk = false
		end
	end)
end
isMuscleWalk = false
if enableMuscleWalk then
	RegisterCommand("musclewalk", function(source, args, rawCommand)
		if isMuscleWalk then
			-- ResetPedMovementClipset
			resetAnims()
			isMuscleWalk = false
			DisplayNotification('~r~You are no longer doing the muscle walk')
		else
			-- Make jogger
			isMuscleWalk = true
			runAnim("move_m@muscle@a")
			DisplayNotification('~g~Success: You are now muscle walking!')
		end
	end)
end
isInjured = false
if enableInjured then
	RegisterCommand("injured", function(source, args, rawCommand)
		if isInjured then
			-- Un injure them
			resetAnims()
			isInjured = false
			DisplayNotification('~g~Success: You are not hurt any more!')
		else
			-- Injure them
			setHurt()
			isInjured = true
			DisplayNotification('~r~You have been injured!')
		end
	end)
end
isHiking = false
if enableHiking then
	RegisterCommand("hiking", function(source, args, rawCommand)
		if isHiking then
			-- Unhike
			isHiking = false
			resetAnims()
			DisplayNotification('~r~You are no longer hiking!')
		else
			-- Hike
			runAnim("move_m@hiking")
			isHiking = true
			DisplayNotification('~g~Success: You are now hiking')
		end
	end)
end

isHealthHurt = false
if enableHealthInjured then
	Citizen.CreateThread(function()
		while true do
			-- Set them injured if health is under 50
			Citizen.Wait(3000)
			--Debug("The health == " .. tostring(GetEntityHealth(GetPlayerPed(-1))) .. " for player with ID: " .. tostring(PlayerId()))
			if GetEntityHealth(GetPlayerPed(-1)) < 140 then
				setHurt()
				isHealthHurt = true
			else
				if isHealthHurt then
					resetAnims()
					isHealthHurt = false
				end
			end
		end
	end)
end

function setHurt()
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function runAnim(anim)
	RequestAnimSet(anim)
	SetPedMovementClipset(GetPlayerPed(-1), anim, true)
end

function resetAnims()
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
end

function Debug(t)
	TriggerEvent("chatMessage", '', { 0, 0x99, 255}, "" .. tostring(t))
end

currentVeh = nil
if enableLock then
	RegisterCommand("lock", function(source, args, rawCommand)
		-- Lock their car - Must be in it
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped, false)
		if veh ~= 0 then
			-- In a vehicle
			local driver = GetPedInVehicleSeat(veh, -1)
			-- Are they the driver?
			if driver == ped then
				--TaskLeaveVehicle(ped, veh, 1)
				SetVehicleDoorsLockedForAllPlayers(veh, true)
				if currentVeh ~= nil and currentVeh ~= veh then
					SetVehicleDoorsLockedForAllPlayers(currentVeh, false) -- Unlock their old vehicle if they are locking this one
				end
				currentVeh = veh
				DisplayNotification('~g~Success: Your vehicle is now locked')
			else
				-- Only the driver can lock the car
				DisplayNotification('~r~Invalid: You must be the driver to lock a vehicle')
			end
		else
			-- Not in a vehicle
			DisplayNotification('~r~Invalid: You must be in a vehicle to lock it')
		end
	end)
end
if enableUnlock then
	RegisterCommand("unlock", function(source, args, rawCommand)
		-- Unlock their car
		if currentVeh ~= nil then
			-- They have a vehicle
			SetVehicleDoorsLockedForAllPlayers(currentVeh, false)
			DisplayNotification('~g~Success: Vehicle is now unlocked')
		else
			-- They do not have a vehicle
			DisplayNotification('~r~Invalid: You currently don\'t own a vehicle')
		end
	end)
end

if enableLockpick then
	RegisterCommand("lockpick", function(source, args, rawCommand)
		-- Lockpick the closest car to them
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)
		local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 2, ped, 0)
		local a, b, c, d, veh = GetRaycastResult(rayHandle)
		if veh ~= currentVeh then
			if veh ~= 0 then
				local isCopCar = false
				for i = 1, #copCars do
					if (GetHashKey(copCars[i]) == GetEntityModel(veh)) then
						isCopCar = true
					end
				end
				local durationTime = lockpickingCarTime * 1000
				local labelStr = lockpickingCarStr
				if isCopCar then
					durationTime = lockpickingCopCarTime * 1000
					labelStr = lockpickingCopCarStr
				end
				----[[
				TriggerEvent("mythic_progressbar:client:progress", {
					name = "BreakingIntoCar",
					duration = durationTime,
					label = labelStr,
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
						anim = "machinic_loop_mechandplayer",
						flags = 49,
					},
					prop = {
						model = "prop_ing_crowbar",
					}
				}, function(status)
					if not status then
						-- Do Something If Event Wasn't Cancelled
						SetVehicleDoorOpen(veh, 0, true, false)
						SetVehicleDoorsLockedForAllPlayers(veh, false)
						SetVehicleNeedsToBeHotwired(veh, true)
						SetVehicleAlarm(veh, 1)
						StartVehicleAlarm(veh)
						DisplayNotification('~g~Success: Vehicle is now broken into!')
					end
				end)
				--]]--
			else
				-- They are not close enough to a car to lockpick
				DisplayNotification('~r~Invalid: You are not close enough to a vehicle')
			end
		else
			-- You can't lockpick your own car
			DisplayNotification('~r~Invalid: You can\'t lockpick your own vehicle')
		end
	end)
end

function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
