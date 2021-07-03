import * as assert from 'assert';
import { expect } from 'chai';

import * as vscode from 'vscode';

const api = "1";

suite('Extension Test Suite', () => {
    vscode.window.showInformationMessage('Start all tests.');

    test('Sample test', () => {
        assert.equal(-1, [1, 2, 3].indexOf(5));
        assert.equal(-1, [1, 2, 3].indexOf(0));
    });
});

suite("Expect API to exist", () => {
    test('Is true?', () => {
        expect(api).to.exist;
    });
});
