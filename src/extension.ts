import * as vscode from 'vscode';
import * as api from "./CoreLuaAPI-Prod.json";

const SCHEME = { scheme: "file", language: "lua" };

interface Parameter {
    Type: string;
    Name?: string;
    IsVariadic?: boolean;
}

export function activate(context: vscode.ExtensionContext): void {
    function getAllNames() {
        const ret = [];

        for (let i = 0; i < api.Classes.length; i++) {
            ret.push(api.Classes[i].Name);
        }

        for (let i = 0; i < api.Namespaces.length; i++) {
            ret.push(api.Namespaces[i].Name);
        }

        for (let i = 0; i < api.Enums.length; i++) {
            ret.push(api.Enums[i].Name);
        }

        return ret;
    }

    const providers: vscode.Disposable[] = [];

    // Enum and Namespace Suggestion
    providers.push(vscode.languages.registerCompletionItemProvider(SCHEME, {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        provideCompletionItems(document: vscode.TextDocument, position: vscode.Position, token: vscode.CancellationToken, context: vscode.CompletionContext) {
            const completions = [];
            // Add a class only if it has a Constructor or Static Function
            for (let i = 0; i < api.Classes.length; i++) {
                if (api.Classes[i].Constructors || api.Classes[i].StaticFunctions) {
                    completions.push(new vscode.CompletionItem(api.Classes[i].Name, vscode.CompletionItemKind.Class));
                }
            }

            // Hardcode "script" as a completion item
            completions.push(new vscode.CompletionItem("script", vscode.CompletionItemKind.Variable));

            for (let i = 0; i < api.Enums.length; i++) {
                completions.push(new vscode.CompletionItem(api.Enums[i].Name, vscode.CompletionItemKind.Enum));
            }

            for (let i = 0; i < api.Namespaces.length; i++) {
                completions.push(new vscode.CompletionItem(api.Namespaces[i].Name, vscode.CompletionItemKind.Class));
            }

            // Return all completion items as array
            return completions;
        }
    }));

    // Create MemberFunction Providers
    // Since Lua is untyped, if they type a : after anything, bring up all method suggestions.
    providers.push(vscode.languages.registerCompletionItemProvider(SCHEME, {
        provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
            const linePrefix = document.lineAt(position).text.substr(0, position.character);
            if (!(linePrefix[linePrefix.length - 1] === ":" && !/\s/.test(linePrefix[linePrefix.length - 2]))) {
                return undefined;
            }

            const methodCompletions = [];

            for (let i = 0; i < api.Classes.length; i++) {
                for (let j = 0; j < api.Classes[i].MemberFunctions.length; j++) {
                    const memberFunction = api.Classes[i].MemberFunctions[j];
                    for (let k = 0; k < memberFunction.Signatures.length; k++) {
                        const signature = memberFunction.Signatures[k];
                        const ci: vscode.CompletionItem = new vscode.CompletionItem(memberFunction.Name, vscode.CompletionItemKind.Method);

                        let parenText = "(";
                        let snippetText = "(";
                        for (let l = 0; l < signature.Parameters.length; l++) {
                            const param: Parameter = <Parameter>signature.Parameters[l];
                            const disp = param.Type;
                            const snip = param.Name ? param.Name : param.Type;

                            if (disp) {
                                parenText += disp;
                                snippetText += "${" + (l + 1).toString() + ":" + snip + "}";
                                if (l < signature.Parameters.length - 1) {
                                    parenText += ", ";
                                    snippetText += ", ";
                                }
                            } else if (param.IsVariadic) {
                                parenText += "...";
                                snippetText += "...";
                                if (l < signature.Parameters.length - 1) {
                                    parenText += ", ";
                                    snippetText += ", ";
                                }
                            }
                        }

                        parenText += ")";
                        snippetText += ")";

                        ci.documentation = new vscode.MarkdownString("`" + api.Classes[i].Name + "." + memberFunction.Name + parenText + "`");
                        ci.insertText = new vscode.SnippetString(memberFunction.Name + snippetText);
                        ci.commitCharacters = ["("];
                        methodCompletions.push(ci);
                    }
                }
            }

            return methodCompletions;
        }
    }, ":")
    );

    // Create Property Providers
    // Since Lua is untyped, if they type a . after anything, bring up all suggestions.
    providers.push(vscode.languages.registerCompletionItemProvider(SCHEME, {
        provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
            const linePrefix = document.lineAt(position).text.substr(0, position.character);
            if (!(linePrefix[linePrefix.length - 1] === "." && !/\s/.test(linePrefix[linePrefix.length - 2]))) {
                return undefined;
            }

            // Check if linePrefix is equal to any Enum, Namespace, or Class name. If so, stop.
            const names = getAllNames();
            for (let i = 0; i < names.length; i++) {
                if (linePrefix.endsWith(names[i] + ".")) {
                    return undefined;
                }
            }

            const completions = [];
            for (let i = 0; i < api.Classes.length; i++) {
                for (let j = 0; j < api.Classes[i].Properties.length; j++) {
                    const ci: vscode.CompletionItem = new vscode.CompletionItem(api.Classes[i].Properties[j].Name, vscode.CompletionItemKind.Field);
                    ci.documentation = new vscode.MarkdownString("`" + api.Classes[i].Name + "." + api.Classes[i].Properties[j].Name + " | " + api.Classes[i].Properties[j].Type + "`");
                    completions.push(ci);
                }
            }

            return completions;
        }
    }, ".")
    );

    // Create Namespace StaticFunction Providers
    for (let i = 0; i < api.Namespaces.length; i++) {
        providers.push(vscode.languages.registerCompletionItemProvider(SCHEME, {
            provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
                const linePrefix = document.lineAt(position).text.substr(0, position.character);
                if (!linePrefix.endsWith(api.Namespaces[i].Name + ".")) {
                    return undefined;
                }

                const completions = [];
                for (let j = 0; j < api.Namespaces[i].StaticFunctions.length; j++) {
                    completions.push(new vscode.CompletionItem(api.Namespaces[i].StaticFunctions[j].Name, vscode.CompletionItemKind.Method));
                }

                const staticEvents = api.Namespaces[i].StaticEvents;
                for (let j = 0; staticEvents && j < staticEvents.length; j++) {
                    completions.push(new vscode.CompletionItem(staticEvents[j].Name, vscode.CompletionItemKind.Constant));
                }

                return completions;
            }
        }, ".")
        );
    }

    // Create Class Constructor and StaticFunction Providers
    for (let i = 0; i < api.Classes.length; i++) {
        providers.push(vscode.languages.registerCompletionItemProvider(SCHEME, {
            provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
                const linePrefix = document.lineAt(position).text.substr(0, position.character);
                if (!linePrefix.endsWith(api.Classes[i].Name + ".")) {
                    return undefined;
                }

                const completions = [];
                const constructors = api.Classes[i].Constructors;
                for (let j = 0; constructors && j < constructors.length; j++) {
                    const ci: vscode.CompletionItem = new vscode.CompletionItem(constructors[j].Name, vscode.CompletionItemKind.Constructor);
                    ci.documentation = new vscode.MarkdownString("`" + api.Classes[i].Name + "." + constructors[j].Name + "() | " + api.Classes[i].Name + "`");
                    completions.push(ci);
                }

                const staticFunctions = api.Classes[i].StaticFunctions;
                for (let j = 0; staticFunctions && j < staticFunctions.length; j++) {
                    const ci: vscode.CompletionItem = new vscode.CompletionItem(staticFunctions[j].Name, vscode.CompletionItemKind.Function);
                    ci.documentation = new vscode.MarkdownString("`" + api.Classes[i].Name + "." + staticFunctions[j].Name + "()`");
                    completions.push(ci);
                }

                return completions;
            }
        }, ".")
        );
    }

    // Create Enum Member Providers
    for (let i = 0; i < api.Enums.length; i++) {
        providers.push(vscode.languages.registerCompletionItemProvider(SCHEME, {
            provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
                const linePrefix = document.lineAt(position).text.substr(0, position.character);
                if (!linePrefix.endsWith(api.Enums[i].Name + ".")) {
                    return undefined;
                }

                const completions = [];
                for (let j = 0; j < api.Enums[i].Values.length; j++) {
                    completions.push(new vscode.CompletionItem(api.Enums[i].Values[j].Name, vscode.CompletionItemKind.EnumMember));
                }

                return completions;
            }
        }, ".")
        );
    }

    for (let i = 0; i < providers.length; i++) {
        context.subscriptions.push(providers[i]);
    }
}
