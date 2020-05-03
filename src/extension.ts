import * as vscode from 'vscode';
import { EnumCompletionProvider } from "./enum"

const SELECTOR = { scheme: "file", language: "lua" }

export function activate(context: vscode.ExtensionContext) {

	let provider1 = vscode.languages.registerCompletionItemProvider(SELECTOR, {

		provideCompletionItems(document: vscode.TextDocument, position: vscode.Position, token: vscode.CancellationToken, context: vscode.CompletionContext) {

			// a simple completion item which inserts `Hello World!`
			const simpleCompletion = new vscode.CompletionItem('Hello World!');

			const commitCharacterCompletion = new vscode.CompletionItem('console');
			commitCharacterCompletion.commitCharacters = ['.'];
			commitCharacterCompletion.documentation = new vscode.MarkdownString('Press `.` to get `console.`');

			// a completion item that retriggers IntelliSense when being accepted,
			// the `command`-property is set which the editor will execute after
			// completion has been inserted. Also, the `insertText` is set so that
			// a space is inserted after `new`
			const commandCompletion = new vscode.CompletionItem('new');
			commandCompletion.kind = vscode.CompletionItemKind.Keyword;
			commandCompletion.insertText = 'new ';
			commandCompletion.command = { command: 'editor.action.triggerSuggest', title: 'Re-trigger completions...' };

			// return all completion items as array
			return [
				simpleCompletion,
				commitCharacterCompletion,
				commandCompletion
			];
		}
	});

	context.subscriptions.push(provider1);
    context.subscriptions.push(vscode.languages.registerCompletionItemProvider(SELECTOR, new EnumCompletionProvider(), "."))
}