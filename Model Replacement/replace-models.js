const fs = require('fs');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const consoleColors = {
    reset: '\x1b[0m',
    fgCyan: '\x1b[36m',
    fgBlack: '\x1b[30m',
    fgRed: '\x1b[31m',
    fgGreen: '\x1b[32m',
    fgYellow: '\x1b[33m',
    fgBlue: '\x1b[34m',
    fgMagenta: '\x1b[35m',
    fgWhite: '\x1b[37m'
};

const fiendList = [
    `Hunter Mob`,
    `Huntsman's Minion`,
    `Scourge Beast`,
    `Church Servant`, 
    `Church Giant`,
    `Male Beast Patient`,
    `Female Beast Patient`,
    `Giant Lost Child`,
    `Small Nightmare Apostle`,
    `Large HuntsMan`,
    `Merciless Watcher`,
    `Loran Silverbeast`,
    `Mergo's Chief Attendant`,
    `Mergo's Attendant`, 
    `Bell Ringer`,
    `Hunting Dog`,
    `Labyrinth Rat`,
    `Fluorescent Flower`,
    `Keeper od the Old Lords`,
    `Gravekeeper Scorpion`,
    `Rabid Dog`,
    `Mad One`,
    `Maneater Boar`,
    `Snake Parasite`, 
    `Snake Ball`, 
    `Hemwick Grave Woman`,
    `Cramped Casket`,
    `Kidnapper`,
    `Cain's Servant`,
    `Vileblood Knight`,
    `Bloodlicker`,
    `Lost Child of Antiquity`,
    `Forsaken Castle Spirit`,
    `Brainsucker`,
    `Celestial Emissary`,
    `Child of Rom`,
    `Garden of Eyes`,
    `Scholar`,
    `Ebrietas, Daughter of the Cosmos`,
    `Mergos's Wet Nurse`,
    `The One Reborn`,
    `Rom, The Vacuous Spider`,
    `Large Nightmare Apostle`,
    `Gehrman, the First Hunter`, 
    `Moon Presence`,
    `Watchdog of the Old Lords`,
    `Undead Giant`,
    `Yharnam, Pthumerian Queen`,
    `Pthumerian Descendant`,
    `Beast-Possessed Soul`,
    `Shadow of Yharnam`,
    `Witch of Hemwick`,
    `Cleric Beast`,
    `Blood-Starved Beast`,
    `Vicar Amelia`,
    `Father Gascoigne`,
    `Father Gascoigne Transformed`,
    `Annalise, Queen of the Vilebloods`,
    `Martyr Logarius`
];

const npcList = [
    `Iosefka`,
    `Old Hunter Henryk`,
    `Bloody Crow of Cainhurst`,
    `Eileen the Crow`,
    `Alfred, Hunter of Vilebloods`,
    `Djura's Ally`,
    `Old Hunter Djura`
];

let originalFile;
let originalFileSize;
let originalData;

let replaceFile;
let replaceFileSize;
let replaceData;

let saveName;

let resizeValue;

/**
 * outputs text to consle/terminal in selected color (defaults to cyan)
 * @param {string} outputText 
 * @param {string} color refer to consoleColors to see the color string format or use one of those
 */
const output = (outputText, color = consoleColors.fgCyan) => {
  console.log(color, outputText, consoleColors.reset);
};

/**
 * Checks if a given var is realy defined and is not null
 * @param {any} val 
 * @returns 
 */
const isDefined = (val) => {
    return typeof(val) !== 'undefined' && val !== undefined && val !== null;
};

/**
 * Get file size in MB
 * @param {string} filename 
 * @returns 
 */
const getFilesize = (filename) => {
    let stats = fs.statSync(filename)
    let fileSizeInBytes = stats.size;
    // Convert the file size to megabytes and return
    return fileSizeInBytes / (1024*1024);
};

/**
 * save the resulting ile using originalData's current state
 */
const saveFile = () => {
    setTimeout(() => { 
        fs.writeFile(saveName, JSON.stringify(originalData), 'utf8', function (err) {
            if (err) {
                output(err, consoleColors.fgRed);
                throw('aborting...');
            }
        
            output('The file was saved!', consoleColors.fgGreen);
        }); 
    }, 1000);
};

/**
 * Handles files names arguments if provided
 */
const handleReplaceArgs = (callback) => {
    rl.question('name of original json file (without extension): ', function(of) {
        rl.question('name of replacement json file (without extension): ', function(rf) {
            rl.question('resulting file name (without extension): ', function(sn) {
                originalFile = `${of}.json`;
                replaceFile = `${rf}.json`;

                originalData = JSON.parse(fs.readFileSync(originalFile));
                replaceData = JSON.parse(fs.readFileSync(replaceFile));

                originalFileSize = getFilesize(originalFile);
                replaceFileSize = getFilesize(replaceFile);

                output(`originalFile: ${originalFile} (${originalFileSize}MB)`);
                output(`replaceFile: ${replaceFile} (${replaceFileSize}MB)`);

                saveName = `${sn}.json`;

                callback();

                rl.close();
            });
        });
    });
};

/**
 * Try to replace all replaceable models
 */
const replaceAll = () => {

    const callback = () => {
        // find and replace all hunters
        replaceHunters(true);

        // find and replace all fiends
        replaceFiends(true);
        
        saveFile();
    };

    handleReplaceArgs(callback);
};

/**
 * Try to replace hunter models
 * @param {boolean} innerCall set to true when calls come from the module itself
 */
const replaceHunters = (innerCall = false) => {
    if (!innerCall) {
        const callback = () => {
            originalData = replaceHuntersRecurs(originalData);
            saveFile();
        };
        handleReplaceArgs(callback);
    } else {
        originalData = replaceHuntersRecurs(originalData);
    }
};

/**
 * get all hunters existing in provided object
 * @param {object} obj 
 * @returns 
 */
const replaceHuntersRecurs = (obj) => {
    if (isDefined(obj) && 'Description' in obj && obj.Description === 'Hunter') {
        obj = replaceModel(obj, 'Hunter');
    }
    
    for (let prop in obj) {
        if (typeof obj[prop] == 'object'){
            obj[prop] = replaceHuntersRecurs(obj[prop]);
        } else if (Array.isArray(obj[prop])) {
            obj[prop].map((subObj, i) => {
                obj[prop][i] = replaceHuntersRecurs(subObj);
            });
        }
    }

    return obj;
};

/**
 * Try to replace fiends models
 * @param {boolean} innerCall set to true when calls come from the module itself
 */
 const replaceFiends = (innerCall = false) => {
    if (!innerCall) {
        const callback = () => {
            originalData = replaceFiendsRecurs(originalData);
            saveFile();
        };
        handleReplaceArgs(callback);
    } else {
        originalData = replaceFiendsRecurs(originalData);
    }
};

/**
 * get all fiends existing in provided object
 * @param {object} obj 
 * @returns 
 */
 const replaceFiendsRecurs = (obj) => {
    if (isDefined(obj) && 'Name' in obj && 'Nickname' in obj && fiendList.includes(obj.Nickname) && (obj.Name === 'Custom_Model' || obj.Name === 'Figurine_Custom')) {
        obj = replaceModel(obj);
    }
    
    for (let prop in obj) {
        if (typeof obj[prop] == 'object'){
            obj[prop] = replaceFiendsRecurs(obj[prop]);
        } else if (Array.isArray(obj[prop])) {
            obj[prop].map((subObj, i) => {
                obj[prop][i] = replaceFiendsRecurs(subObj);
            });
        }
    }

    return obj;
};

/**
 * Replace the provided model with the matched one
 * @param {object} obj 
 */
 const replaceModel = (obj, model = 'Model') => {
    output(`Replacing ${model}: ${obj.Nickname}`, consoleColors.fgYellow);

    const objCopy = JSON.parse(JSON.stringify(obj));
    let match = findMatch(replaceData, obj.Nickname);

    if (isDefined(match)) {
        output(`match found for ${obj.Nickname}`, consoleColors.fgGreen);
        // replace obj with match
        obj = match;
        // use orignal values for the next keys, these are to maintain the scripted stuff working
        obj.GUID = objCopy.GUID; 
        obj.Description = objCopy.Description;
        obj.LuaScript = objCopy.LuaScript;
        obj.LuaScriptState = objCopy.LuaScriptState;
        obj.CustomUIAssets = objCopy.CustomUIAssets;
        obj.Nickname = objCopy.Nickname;
    } else {
        output(`no match found for ${obj.Nickname}`, consoleColors.fgRed);
    }

    return obj;
};


/**
 * Find a match object with provided nickname and, optionaly, a description.
 * @param {object} obj 
 * @param {string} nickname 
 * @param {string} description 
 * @returns 
 */
const findMatch = (obj, nickname, description = null) => {
    let match = null;
    
    if (isDefined(obj) && 'Nickname' in obj && obj.Nickname.replace(' (CD)', '') === nickname && (description === null || obj.Description === description)) {
        match = obj;
    }

    for (let prop in obj) {
        if (typeof obj[prop] == 'object'){
            let subMatch = findMatch(obj[prop], nickname);
            if (subMatch !== null) {
                match = subMatch;
            }
        } else if (Array.isArray(obj[prop])) {
            obj[prop].map((subObj) => {
                let subMatch = findMatch(subObj, nickname);
                if (subMatch !== null) {
                    match = subMatch;
                }
            });
        }
    }

    return match;
}

/**
 * Handles file name and resize value arguments.
 */
 const handleResizeArgs = (callback) => {
    rl.question(`name of json file (without extension): `, function(of) {
        rl.question(`resize value (use negative value to shrink): `, function(rv) {
            rl.question('resulting file name (without extension): ', function(sn) {
                originalFile = `${of}.json`;
                originalData = JSON.parse(fs.readFileSync(originalFile));
                originalFileSize = getFilesize(originalFile);
                output(`originalFile: ${originalFile} (${originalFileSize}MB)`);

                if (!isNaN(rv)) {
                    resizeValue = rv;
                    output(`resizeValue: ${resizeValue}`);
                }

                saveName = `${sn}.json`;

                callback();

                rl.close();
            });
        });
    });
};

/**
 * Try to resize all resizable models
 */
 const resizeAll = () => {

    const callback = () => {
        // find and replace all hunters
        resizeHunters(true);

        // find and replace all fiends
        resizeFiends(true);
        
        saveFile();
    };

    handleResizeArgs(callback);
};

/**
 * Resizes all hunters.
 */
const resizeHunters = (innerCall = false) => {
    if (!innerCall) {
        const callback = () => {
            originalData = resizeHuntersRecurs(originalData);
            
            saveFile();
        };

        handleResizeArgs(callback);
    } else {
        originalData = resizeHuntersRecurs(originalData);
    }
}

/**
 * get all hunters existing in provided object
 * @param {object} obj 
 * @returns 
 */
 const resizeHuntersRecurs = (obj) => {
    if (isDefined(obj) && 'Description' in obj && obj.Description === 'Hunter') {
        obj = resizeModel(obj, 'Hunter');
    }
    
    for (let prop in obj) {
        if (typeof obj[prop] == 'object'){
            obj[prop] = resizeHuntersRecurs(obj[prop]);
        } else if (Array.isArray(obj[prop])) {
            obj[prop].map((subObj, i) => {
                obj[prop][i] = resizeHuntersRecurs(subObj);
            });
        }
    }

    return obj;
};

/**
 * Resizes all fiends.
 */
 const resizeFiends = (innerCall = false) => {
    if (!innerCall) {
        const callback = () => {
            originalData = resizeFiendsRecurs(originalData);
            
            saveFile();
        };

        handleResizeArgs(callback);
    } else {
        originalData = resizeFiendsRecurs(originalData);
    }
}

/**
 * get all fiends existing in provided object
 * @param {object} obj 
 * @returns 
 */
 const resizeFiendsRecurs = (obj) => {
    if (isDefined(obj) && 'Name' in obj && 'Nickname' in obj && fiendList.includes(obj.Nickname) && (obj.Name === 'Custom_Model' || obj.Name === 'Figurine_Custom')) {
        obj = resizeModel(obj, 'Hunter');
    }
    
    for (let prop in obj) {
        if (typeof obj[prop] == 'object'){
            obj[prop] = resizeFiendsRecurs(obj[prop]);
        } else if (Array.isArray(obj[prop])) {
            obj[prop].map((subObj, i) => {
                obj[prop][i] = resizeFiendsRecurs(subObj);
            });
        }
    }

    return obj;
};

/**
 * Resizes the provided model by adding the specified resizeValue to current scale
 * @param {object} obj 
 */
const resizeModel = (obj, model = 'Model') => {
    output(`Resizing ${model}: ${obj.Nickname}`, consoleColors.fgYellow);

    if (Number.parseFloat(Number.parseFloat(obj.Transform.scaleX)) < 6) {
        output(`original scaleX ${obj.Transform.scaleX} + ${resizeValue}`);
        obj.Transform.scaleX = (Number.parseFloat(obj.Transform.scaleX) + Number.parseFloat(resizeValue)).toString();
        output(`new scaleX ${obj.Transform.scaleX}`);
        obj.Transform.scaleY = (Number.parseFloat(obj.Transform.scaleY) + Number.parseFloat(resizeValue)).toString();
        obj.Transform.scaleZ = (Number.parseFloat(obj.Transform.scaleZ) + Number.parseFloat(resizeValue)).toString();

        output(`sucessfull resize of ${obj.Nickname}`, consoleColors.fgGreen);
    } else {
        output(`size is already large ${obj.Nickname}`, consoleColors.fgMagenta);
    }

    return obj;
};

/**
 * Handles files names arguments if provided
 */
 const handleReplaceAndResizeArgs = (callback) => {
    rl.question('name of original json file (without extension): ', function(of) {
        rl.question('name of replacement json file (without extension): ', function(rf) {
            rl.question(`resize value (use negative value to shrink): `, function(rv) {
                rl.question('resulting file name (without extension): ', function(sn) {
                    originalFile = `${of}.json`;
                    replaceFile = `${rf}.json`;

                    originalData = JSON.parse(fs.readFileSync(originalFile));
                    replaceData = JSON.parse(fs.readFileSync(replaceFile));

                    originalFileSize = getFilesize(originalFile);
                    replaceFileSize = getFilesize(replaceFile);

                    output(`originalFile: ${originalFile} (${originalFileSize}MB)`);
                    output(`replaceFile: ${replaceFile} (${replaceFileSize}MB)`);

                    if (!isNaN(rv)) {
                        resizeValue = rv;
                        output(`resizeValue: ${resizeValue}`);
                    }

                    saveName = `${sn}.json`;

                    callback();

                    rl.close();
                });
            });
        });
    });
};

/**
 * Try to replace and resize all possible models
 */
const replaceAndResizeAll = () => {

    const callback = () => {
        // find and replace all hunters
        replaceHunters(true);

        // find and replace all fiends
        replaceFiends(true);

        resizeHunters(true);

        resizeFiends(true);
        
        saveFile();
    };

    handleReplaceAndResizeArgs(callback);
};

module.exports = {
    replaceAll,
    replaceHunters,
    replaceFiends,
    
    resizeAll,
    resizeHunters,
    resizeFiends,

    replaceAndResizeAll
}