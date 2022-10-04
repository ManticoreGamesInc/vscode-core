import * as vscode from "vscode";
import * as path from "path";

type AnyObject = Record<string, unknown>;
const getLuaConfig = () => {return vscode.workspace.getConfiguration("Lua", null);};

export function activate(context: vscode.ExtensionContext) {
    vscode.window.showInformationMessage("Core Lua API extension activated!");    
    setExternalLibrary(path.join("out", "EmmyLua"), true);
    setPreloadSize();
    setBuiltins(context);
}

export function deactivate() {
    vscode.window.showInformationMessage("Core Lua API extension deactivated!");
    setExternalLibrary(path.join("out", "EmmyLua"), false);
}

/**
 * Set the default libraries configuration for the current core project (workspace)
 */
export function setExternalLibrary(folder: string, enable: boolean) {
    console.log("setExternalLibrary", folder, enable);
    const extensionId = "manticoregames.vscode-core";
    const extensionPath = vscode.extensions.getExtension(extensionId)?.extensionPath;
    const folderPath = extensionPath ? path.join(extensionPath, folder) : "";
    const library: string[] | undefined = getLuaConfig().get("workspace.library");
    if (library && extensionPath) {
        // remove any older versions of our path e.g. "publisher.name-0.0.1"
        for (let i = library.length - 1; i >= 0; i--) {
            const el = library[i];
            const isSelfExtension = el.indexOf(extensionId) > -1;
            const isCurrentVersion = el.indexOf(extensionPath) > -1;
            if (isSelfExtension && !isCurrentVersion) {
                library.splice(i, 1);
            }
        }
        const index = library.indexOf(folderPath);
        if (enable) {
            if (index === -1) {
                library.push(folderPath);
            }
        }
        else {
            if (index > -1) {
                library.splice(index, 1);
            }
        }
        getLuaConfig().update("workspace.library", library);
    }
}

/**
 * Change the default preload file size configuration for the current core project (workspace)
 */
export function setPreloadSize() {
    const currentSize: number = getLuaConfig().get("workspace.preloadFileSize") || 150;
    if (currentSize < 400) {
        // increase preloadFileSize to make sure our config gets loaded
        getLuaConfig().update("workspace.preloadFileSize", 400);
        console.log("Bumping preloadFileSize");
    }
}

/**
 * Test if two objects have the same members
 * @param First First object
 * @param Second Second object
 * @returns True if they are similar
 */
export function shallowEqual(First : AnyObject | undefined | null, Second : AnyObject | undefined | null) : boolean {
    First = First as AnyObject;
    Second = Second as AnyObject;
    if (!First || !Second) {
        return false;
    }
    const FirstMembers = Object.keys(First);
    const SecondMembers = Object.keys(Second);
    if (FirstMembers.length !== SecondMembers.length) {
        return false;
    }
    for (const Member of FirstMembers) {
        if (First[Member] !== Second[Member]) {
            return false;
        }
    }
    return true;
}

/**
 * Change the default builtins configuration for new core project or use the user defined
 * Also register the command SetLuaBuiltins (Core Enable/Disable Lua builtins) wich switch between user/core builtins
 * @param context The vscode extension context
 */
export function setBuiltins(context: vscode.ExtensionContext) {
    const builtinsCmd = 'extension.SetLuaBuiltins';
    const coreBuiltins = {
        "basic": "disable",
        "io": "disable",
        "os": "disable",
        "debug": "disable",
        "package": "disable",
        "string": "disable"
    };

    function getBuiltinState() : AnyObject | undefined {
        return context.workspaceState.get('userLuaBuiltins');// || undefined;
    }
    function updateBuiltinState(value : unknown) {
        context.workspaceState.update('userLuaBuiltins', value);
    }

    function getBuiltinConfig() : AnyObject | undefined {
        return getLuaConfig().get("runtime.builtin");
    }
    function updateBuiltinConfig(value : unknown) {
        getLuaConfig().update("runtime.builtin", value);
    }

    function logBuiltins(bIsConsole: boolean, OptMessage? : string) {
        const Msg = `${OptMessage} state:${JSON.stringify(getBuiltinState())}, conf:${JSON.stringify(getBuiltinConfig())}`;
        (bIsConsole ? console.log(Msg) : vscode.window.showInformationMessage(Msg));
    }

    function getBuiltinsMsg() : string {
        return `state:${JSON.stringify(getBuiltinState())}, conf:${JSON.stringify(getBuiltinConfig())}`;
    }

    let count = 0;
    function getCounter() : number {
        return count++;
    }

    let bHasSwitched = false;
    function switchBuiltins() {
        const preChangeMsg : string = getBuiltinsMsg();
        bHasSwitched = true;
        if (shallowEqual(getBuiltinConfig() as AnyObject, coreBuiltins as AnyObject)) {
            updateBuiltinConfig(getBuiltinState()); 
            updateBuiltinState(undefined);
        } else {
            updateBuiltinState(getBuiltinConfig());
            updateBuiltinConfig(coreBuiltins);
        }
        logBuiltins(true, `${getCounter()} Switched From: ${preChangeMsg}\n To:`);
    }

    // updateBuiltinState(undefined); // simulate first run
    logBuiltins(true, `${getCounter()} Initial value`);
    // only the first time a project is started and the user has not set builtin config, then we disable sumneko builtins
    if (!getBuiltinState() && shallowEqual(getBuiltinConfig() as AnyObject, {} as AnyObject)) {
        switchBuiltins();
    }

    const commandDisposable = vscode.commands.registerCommand(builtinsCmd, () => {
        switchBuiltins();
    });
    const configEventDisposable = vscode.workspace.onDidChangeConfiguration(event => {
        if (event.affectsConfiguration("Lua")) {
            console.log("lua change!");
            const preChangeMsg : string = getBuiltinsMsg();

            if ( (!shallowEqual(getBuiltinState() as AnyObject, getBuiltinConfig() as AnyObject)) && bHasSwitched === false) {
                updateBuiltinState(getBuiltinConfig());
            } else if (bHasSwitched === true) {
                bHasSwitched = false;
                console.log("pp");
            }
            logBuiltins(true, `${getCounter()} Changed From: ${preChangeMsg}\n To:`);
        }
    });

	context.subscriptions.push(
        commandDisposable,
        configEventDisposable
    );
}

