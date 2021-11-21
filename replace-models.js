const fs = require('fs');

const consoleColors = {
    reset: "\x1b[0m",
    fgCyan: "\x1b[36m",
    fgBlack: "\x1b[30m",
    fgRed: "\x1b[31m",
    fgGreen: "\x1b[32m",
    fgYellow: "\x1b[33m",
    fgBlue: "\x1b[34m",
    fgMagenta: "\x1b[35m",
    fgWhite: "\x1b[37m"
};

let originalFile;
let originalFileSize;
let originalData;

let replaceFile;
let replaceFileSize;
let replaceData;

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
 * save the originalFile using originalData's current state
 */
const saveOriginalFile = () => {
    setTimeout(() => { 
        fs.writeFile(originalFile, JSON.stringify(originalData), 'utf8', function (err) {
            if (err) {
                output(err, consoleColors.fgRed);
                throw('aborting...');
            }
        
            output('The file was saved!', consoleColors.fgGreen);
        }); 
    }, 1000);
};

/**
 * Handles file name arguments if provided
 */
const handleArgs = () => {
    if (isDefined(process.argv[1]) && isDefined(process.argv[2])) {
        // args for both file names was provided
        originalFile = process.argv[1].toString() + '.json';
        replaceFile = process.argv[2].toString() + '.json';

        originalData = JSON.parse(fs.readFileSync(originalFile));
        replaceData = JSON.parse(fs.readFileSync(replaceFile));

        originalFileSize = getFilesize(originalFile);
        replaceFileSize = getFilesize(replaceFile);

        output('originalFile: ' + originalFile + '(' + originalFileSize + 'MB)');
        output('replaceFile: ' + replaceFile + '(' + replaceFileSize + 'MB)');
    }
    
    if (!isDefined(originalData) || !isDefined(replaceData)) {
        output('the names of original and replacement files must be provided as arguments', consoleColors.fgRed);
        throw('aborting...');
    }
};

/**
 * Try to replace all replaceable models
 */
const replaceAll = () => {
    handleArgs();

    // find and replace all hunters
    replaceHunters(true);
    
    saveOriginalFile();
};

/**
 * Try to replace hunter models
 * @param {boolean} innerCall set to true when calls come from the module itself
 */
const replaceHunters = (innerCall = false) => {
    if (!innerCall) {
        handleArgs();
    }

    originalData = replaceHuntersRecurs(originalData);

    if (!innerCall) {
        saveOriginalFile();;
    }
};

/**
 * Replace the provided hunter model with the matched one
 * @param {object} hunter 
 */
const replaceHunter = (hunter) => {
    output('Replacing Hunter: ' + hunter.Nickname, consoleColors.fgYellow);

    const hunterCopy = JSON.parse(JSON.stringify(hunter));
    let match = findMatch(replaceData, hunter.Nickname);

    if (isDefined(match)) {
        output('match found for ' + hunter.Nickname, consoleColors.fgGreen);
        // replace hunter with match
        hunter = match;
        // use orignal hunter values for the next keys, these are to maintain the scripted stuff working
        hunter.GUID = hunterCopy.GUID; 
        hunter.Description = hunterCopy.Description;
        hunter.LuaScript = hunterCopy.LuaScript;
        hunter.LuaScriptState = hunterCopy.LuaScriptState;
        hunter.CustomUIAssets = hunterCopy.CustomUIAssets;
    } else {
        output('no match found for ' + hunter.Nickname, consoleColors.fgRed);
    }

    return hunter;
};

/**
 * get all hunters existing in provided object
 * @param {object} obj 
 * @returns 
 */
const replaceHuntersRecurs = (obj) => {
    if (isDefined(obj) && 'Description' in obj && obj.Description === 'Hunter') {
        obj = replaceHunter(obj);
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
 * Find a match object with provided nickname and, optionaly, a description.
 * @param {object} obj 
 * @param {string} nickname 
 * @param {string} description 
 * @returns 
 */
const findMatch = (obj, nickname, description = null) => {
    let match = null;
    
    if (isDefined(obj) && 'Nickname' in obj && obj.Nickname === nickname && (description === null || obj.Description === description)) {
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

module.exports = {
    replaceAll,
    replaceHunters
}