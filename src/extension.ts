import * as vscode from 'vscode'
import * as api from "./CoreLuaAPI-Prod.json"

const SELECTOR = { scheme: "file", language: "lua" }

export function activate(context: vscode.ExtensionContext) {
    let providers: vscode.Disposable[] = []
    let classProvider = vscode.languages.registerCompletionItemProvider(SELECTOR, {
        provideCompletionItems(document: vscode.TextDocument, position: vscode.Position, token: vscode.CancellationToken, context: vscode.CompletionContext) {
            let completions = [];
            for (let i = 0; i < api.Classes.length; i++) {
                completions.push(new vscode.CompletionItem(api.Classes[i].Name, vscode.CompletionItemKind.Class))
            }

            for (let i = 0; i < api.Enums.length; i++) {
                completions.push(new vscode.CompletionItem(api.Enums[i].Name, vscode.CompletionItemKind.Enum))
            }

            for (let i = 0; i < api.Namespaces.length; i++) {
                completions.push(new vscode.CompletionItem(api.Namespaces[i].Name, vscode.CompletionItemKind.Class))
            }

            // return all completion items as array
            return completions
        }
    })
    providers.push(classProvider)

    // Create Class MemberFunction Providers
    for (let i = 0; i < api.Classes.length; i++) {
        providers.push(vscode.languages.registerCompletionItemProvider(SELECTOR, {
            provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
                let linePrefix = document.lineAt(position).text.substr(0, position.character)
                if (!linePrefix.endsWith(api.Classes[i].Name + ".")) {
                    return undefined;
                }

                let methodCompletions = []
                for (let j = 0; j < api.Classes[i].MemberFunctions.length; j++) {
                    methodCompletions.push(new vscode.CompletionItem(api.Classes[i].MemberFunctions[j].Name, vscode.CompletionItemKind.Method))
                }

                return methodCompletions
            }
        }, ".")
        )
    }

    // Create Namespace StaticFunction Providers
    for (let i = 0; i < api.Namespaces.length; i++) {
        providers.push(vscode.languages.registerCompletionItemProvider(SELECTOR, {
            provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
                let linePrefix = document.lineAt(position).text.substr(0, position.character)
                if (!linePrefix.endsWith(api.Namespaces[i].Name + ".")) {
                    return undefined
                }

                let methodCompletions = [];
                for (let j = 0; j < api.Namespaces[i].StaticFunctions.length; j++) {
                    methodCompletions.push(new vscode.CompletionItem(api.Namespaces[i].StaticFunctions[j].Name, vscode.CompletionItemKind.Method))
                }

                return methodCompletions
            }
        }, ".")
        )
    }

    // Create Enum Member Providers
    for (let i = 0; i < api.Enums.length; i++) {
        providers.push(vscode.languages.registerCompletionItemProvider(SELECTOR, {
            provideCompletionItems(document: vscode.TextDocument, position: vscode.Position) {
                let linePrefix = document.lineAt(position).text.substr(0, position.character)
                if (!linePrefix.endsWith(api.Enums[i].Name + ".")) {
                    return undefined
                }

                let completions = [];
                for (let j = 0; j < api.Enums[i].Values.length; j++) {
                    completions.push(new vscode.CompletionItem(api.Enums[i].Values[j].Name, vscode.CompletionItemKind.EnumMember))
                }

                return completions
            }
        }, ".")
        )
    }

    for (let i = 0; i < providers.length; i++) {
        context.subscriptions.push(providers[i])
    }
}