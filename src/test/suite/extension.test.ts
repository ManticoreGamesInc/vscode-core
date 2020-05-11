import * as assert from 'assert';
var expect = require('chai').expect;

// You can import and use all API from the 'vscode' module
// as well as import your extension to test it
import * as vscode from 'vscode';
// import * as myExtension from '../../extension';
import { getApiDump, ApiEnum } from "./../../api";

suite('Extension Test Suite', () => {
	vscode.window.showInformationMessage('Start all tests.');

	test('Sample test', () => {
		assert.equal(-1, [1, 2, 3].indexOf(5));
		assert.equal(-1, [1, 2, 3].indexOf(0));
	});
});

suite("Expect API to exist", () => {
	test('Is true?', () => {
		expect(getApiDump).to.be.exist;
	});
});