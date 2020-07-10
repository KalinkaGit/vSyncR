[<img src="https://img.shields.io/github/v/release/KalinkaGit/vSyncR">]() [<img src="https://img.shields.io/github/issues/KalinkaGit/vSyncR">](https://github.com/KalinkaGit/vSyncR/issues) [<img src="https://img.shields.io/github/downloads/KalinkaGit/vSyncR/total">](https://github.com/KalinkaGit/vSyncR/releases)

# vSyncR
vSyncR (vSyncRevamped) is an improved and updated version with new features of vSync originally created by Vespura. 
vSyncR allows you to control and synchronize weather and time without any prerequisite.

# v1.0.3 Update
- Added bresilian portuguese translation made by [Richards0nd](https://github.com/Richards0nd). Thanks to him!

# Translation Credits
**Portuguese**: [raphapt](https://github.com/raphapt)\
**Turkish**: [thegambid](https://github.com/thegambid)\
**Bresilian Portuguese**: [Richards0nd](https://github.com/Richards0nd)

# New Features
- Configuration file (config.lua) that allows a simpler and more detailed configuration of the script.
- You can now allow commands to the authorized groups or to the players with their identifier.
- vSyncR is completely translated in english and french ! (You can send me new translation by pull request)
- Script updated to last FX version.

Much more in the future...
# Original Features
- Dynamic changing weather every 10 minutes (can be now changed in configuration file with vSyncR. can be (temporarily or permanently) disabled. The weather will only change according to realistic patterns.).
- Blackout. Enable/disable this in the config or using /blackout ingame.
- Weather and Time synced across all players.
- Custom permissions for the commands.

# Commands
`/weather <type>` Change the weather type (will fade to the new weather type within 15 seconds).\
`/freezeweather` Enable/disable dynamic weather changes.\
`/time <h> <m>` Set the time.\
`/freezetime` Freeze/unfreeze time.\
`/morning` Set the time to morning.\
`/noon` Set the time to noon.\
`/evening` Set the time to evening.\
`/night` Set the time to night.\
`/blackout` Enable/disable blackout mode.

# Installation
- [DOWNLOAD HERE](https://github.com/KalinkaGit/vSyncR/releases)
- Put folder `vSyncR` in the `server-data` directory
- Configure vSyncR in `config.lua`
- Add this to your `server.cfg`: 
```
start vSyncR
```
