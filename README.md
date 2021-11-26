# tts-bloodborne-tbg
This was originaly just a script to replace the models in one Mod with the ones from a different one. But it ended up becoming the repo for an implementation of a Tabletop Simulator <font color="red">Bloodborne: The Board Game</font> Mod.

## TTS Lua
Folder <font color="cyan">TTS Lua</font> contains the lua scripts to automate actions of the Mod.

## Model Replacement
Node.js script to replace the models/assets of a Tabletop Simulator's Bloodborne The Board Game Mod with the ones from a different Mod for the same game.
### Run
`node -e "require('./replace-models').replaceAll()"`

you'll be prompted for file names. example files are included in repo.

## Contributing
Help is appreciated, either by contibuting to the project or making suggestions on what to improve.

If you want to help by contributing to the project, please ensure you have the following prerequisites:
- Tabletop Simulator Game
- [VS Code](https://code.visualstudio.com/) with [Tabletop Simulator Lua](https://marketplace.visualstudio.com/items?itemName=rolandostar.tabletopsimulator-lua) (Alternatively, you can use [Atom](https://atom.io/) with [TTS Atom plugin](https://github.com/Berserk-Games/atom-tabletopsimulator-lua/wiki/Installation))

Once you have your tools ready, follow these guidelines to get started:

1. Subscribe to the Codenames workshop mod.
1. Start Tabletop Simulator.
1. On TTS, Create a new server.
1. Load the workshop mod (Games > Workshop > Codenames).
1. Open up VS Code (or Atom).
1. Use `Ctrl + ALT + L` key combination to get LUA scripts from the running game. (`Ctrl + Shift + L` on Atom).
1. Clone this repository.
1. Copy the contents of the files from TTS Lua folder and paste them on your corresponding local instance.
1. Apply any changes to your loading game using `Ctrl + Alt + S`. (`Ctrl + Shift + S` on Atom).


## Credits
This mod wasn't started from scratch, so credit needs to be given:
- [LetsGoMets's Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2409632034) - the base Mod already with some very good scripting.
- [Grimnir(Rus)'s Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2405460038) - used to get the 3d models.
