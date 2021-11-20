const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

// var Exercice1Solution = artifacts.require("Exercice1Solution.sol");
// var evaluator = artifacts.require("Evaluator.sol");
var TDErc20 = artifacts.require("ERC20TD.sol");

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await getPoints(deployer, network, accounts); 
    });
};


async function getPoints(deployer, network, accounts) {
    console.log(accounts);
	TokenTD = await TDErc20.at("0xbf23538e0c8AB87f517E2d296cb0E71D3d3AFE8F");
	var balance = await TokenTD.balanceOf(accounts[0]);
    balance = new web3.utils.BN(balance).toString();
    balance = web3.utils.fromWei(balance, 'ether');    ;
	console.log('Balance: ', balance);
}


