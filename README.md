# tts-bloodborne-tbg
This was originaly just a script to replace the models in one Mod with the ones from a different one. But it ended up becoming the repo for an implementation of a <font color="red">Bloodborne: The Board Game</font> Mod.

## TTS Lua
Folder <font color="cyan">TTS Lua</font> contains the lua scripts to automate actions of the Mod.

## Model Replacement
Node.js script to replace the models/assets of a Tabletop Simulator's Bloodborne The Board Game Mod with the ones from a different Mod for the same game.
### Run
`node -e "require('./replace-models').replaceAll()"`

you'll be prompted for file names. example files are included in repo.

## Credits
This mod wasn't started from scratch, so credit needs to be given:
- [LetsGoMets's Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2409632034) - the base Mod already with some very good scripting.
- [Grimnir(Rus)'s Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2405460038) - used to get the 3d models.
