import * as vscode from "vscode";

export function activate() {
    setExternalLibrary("out\\EmmyLua", true);
}

export function setExternalLibrary(folder: string, enable: boolean) {
    console.log("setExternalLibrary", folder, enable);
    const extensionId = "ManticoreGames.vscode-core";
    const extensionPath = vscode.extensions.getExtension(extensionId)?.extensionPath;
    const folderPath = extensionPath + "\\" + folder;
    const config = vscode.workspace.getConfiguration("Lua");
    const library: string[] | undefined = config.get("workspace.library");
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
        config.update("workspace.library", library, true);
    }
}
