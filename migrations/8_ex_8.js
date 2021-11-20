const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var evaluator = artifacts.require("Evaluator.sol");
var TDErc20 = artifacts.require("ERC20TD.sol");

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployExerciceSolution(deployer, network, accounts); 
        await validateExo(deployer, network, accounts); 
    });
};

async function deployExerciceSolution(deployer, network, accounts) {
	Exsol = await ExerciceSolution.new("GMEx3", "@gauthiermyr Ex3", web3.utils.toBN("752585572000000000000000000"));
}

async function validateExo(deployer, network, accounts) {
	Evaluator = await evaluator.at("0xcff8985FF63cDce92036A2747605FB7ead26423e");
	TokenTD = await TDErc20.at("0xbf23538e0c8AB87f517E2d296cb0E71D3d3AFE8F");
	//submit exercice
	await Evaluator.submitExercice(Exsol.address);

	//whitelist user
	await Exsol.whiteListUser(Evaluator.address);
	//set user level
	await Exsol.setUserLevel(Evaluator.address, 1);

	await Evaluator.ex8_testTier1Listing();
	
	//check new balance
	var balance = await TokenTD.balanceOf(accounts[0]);
    balance = new web3.utils.BN(balance).toString();
    balance = web3.utils.fromWei(balance, 'ether');    ;
	console.log('Balance: ', balance);
}



