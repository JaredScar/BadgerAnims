# BadgerAnims
**Version 1.0**
This is basically just a script I threw together for my server with a bunch of useful walking styles, animations, and features.

One of the features is if a player is at 50% or less health that they then are set to the walking style limping automatically and will continue to walk like that until they are not under 50% health.

**Note**
For the lockpicking feature to work, you must have this script installed properly as well ---> https://forum.fivem.net/t/dev-resource-mythic-progress-bar/527607

All of the features in this script can be toggled on/off via the config section within the client.lua file.

**Config**
```
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
```

**Features**
/drunk - Toggles your ped's walking style between drunk and sober.

/injured - Toggles your ped's walking style between limping and regular.

/hiking - Toggles your ped's walking style between hiking and regular.

/musclewalk - Toggles your ped's walking style between musclewalk and regular.

/lock - Locks the vehicle you are sitting in.

/unlock - Unlocks the vehicle you had previously locked with /lock.

/lockpick - Breaks into the closest vehicle to you.

**Screenshots**

Hiking:
https://i.gyazo.com/b767489678f953b5f099e731d40dbc07.gif

MuscleWalk:
https://i.gyazo.com/5082d61bd58a3832c9230c0bde2dcd8c.gif

Drunk:
https://i.gyazo.com/bdea07bffeda38ef29df5d51a6b5179f.gif

Injured:
https://i.gyazo.com/8371b3fe54928dd3e6edebf25343ef9d.gif

Lockpicking:
https://i.gyazo.com/63ff9b93b136bfb86a8aca4be0cbe612.gif

**Download**
[BadgerAnims](https://github.com/TheWolfBadger/BadgerAnims)

**Installation**
1. Download BadgerAnims
2. Extract the .zip and place the folder in your /resources/ of your Fivem server
3. Make sure you add "start BadgerAnims" in your server.cfg
4. Enjoy :slight_smile:

**My Other Work**

[DiscordChatRoles](https://forum.fivem.net/t/discordchatroles-release/566338)

[DiscordAcePerms](https://forum.fivem.net/t/discordaceperms-release/573044)

[SandyVehiclesRestrict](https://forum.fivem.net/t/release-sandy-vehicles-restrict/564929)

[DiscordTagIDs](https://forum.fivem.net/t/discordtagids-i-know-i-know-i-only-make-discord-based-scripts/582513)

[DiscordVehiclesRestrict](https://forum.fivem.net/t/discordvehiclesrestrict/599594)

[DiscordPedPerms](https://forum.fivem.net/t/release-discordpedperms/642866)

[BadgerAnims](https://forum.fivem.net/t/release-badgeranims/650517)

[DiscordWeaponPerms](https://forum.fivem.net/t/release-discordweaponperms/664774)
