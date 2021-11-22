const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var evaluator = artifacts.require("Evaluator.sol");

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await validateExo(deployer, network, accounts); 
    });
};


async function validateExo(deployer, network, accounts) {
	Evaluator = await evaluator.at("0xcff8985FF63cDce92036A2747605FB7ead26423e");
	
	//validate exercice
	await Evaluator.ex1_getTickerAndSupply();
    var ticker = await Evaluator.readTicker(accounts[0]);
    var supply = await Evaluator.readSupply(accounts[0]);
    supply = new web3.utils.BN(supply).toString();
    console.log('Ticker: ', ticker);
    console.log('Supply: ', supply);
}


