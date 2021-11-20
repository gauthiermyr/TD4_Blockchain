const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var allInOne = artifacts.require("AllInOne.sol");
var TDErc20 = artifacts.require("ERC20TD.sol");

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployAllInOne(deployer, network, accounts); 
        await execute(deployer, network, accounts); 
    });
};

async function deployAllInOne(deployer, network, accounts) {
	AllInOneContract = await allInOne.new("0xcff8985FF63cDce92036A2747605FB7ead26423e");
	console.log("AllInOne: ", AllInOneContract.address, " - Deployer: ", accounts[0]);
}

async function execute(deployer, network, accounts) {
	TokenTD = await TDErc20.at("0xbf23538e0c8AB87f517E2d296cb0E71D3d3AFE8F");
	//submit exercice
	await AllInOneContract.execute();
	
	//check new balance
	var balance = await TokenTD.balanceOf(AllInOneContract.address);
    balance = new web3.utils.BN(balance).toString();
    balance = web3.utils.fromWei(balance, 'ether');    ;
	console.log('Balance: ', balance);
}



