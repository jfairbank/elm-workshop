/* eslint-disable global-require, import/no-dynamic-require, no-console */
const { compile } = require('node-elm-compiler');
const path = require('path');

const inputFile = path.resolve(__dirname, 'Main.elm');
const outputFile = path.resolve(__dirname, 'main.js');

const options = {
  output: outputFile,
  yes: true,
};

compile([inputFile], options).on('close', (exitCode) => {
  if (exitCode === 0) {
    const { Main } = require(outputFile);

    Main.worker().ports.sendOutput.subscribe((output) => {
      console.log('');
      console.log(output);
    });
  }
});
