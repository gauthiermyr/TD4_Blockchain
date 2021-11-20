pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./IExerciceSolution.sol";

contract ExerciceSolution is IExerciceSolution, ERC20 
{

    using SafeMath for uint256;
	address payable private owner_; // contract owner
	mapping(address => bool) public whitelist_; //mapping to avoid getToken abuse
	mapping(address => uint256) public level_; //mapping to avoid getToken abuse
	uint256 private earned_; //total eth received

	//supply: 752585572000000000000000000
	//ticker: 8cMh6
    constructor(string memory symbol, string memory name, uint256 supply) public ERC20(name, symbol){
        _mint(msg.sender, supply);
		owner_ = msg.sender;   
	}

	function symbol() override(IExerciceSolution, ERC20) public view returns (string memory){
		return ERC20.symbol();
	}

	function getToken() override external returns (bool){
		require(whitelist_[msg.sender], "You're not whitelisted");

		uint256 beforeBalance = ERC20.balanceOf(msg.sender);
		_mint(msg.sender, 1 ether);
		uint256 afterBalance = ERC20.balanceOf(msg.sender);

		return afterBalance - beforeBalance == 1 ether;
	}

	function buyToken() override external payable returns (bool){
		require(whitelist_[msg.sender], "You're not whitelisted");
		require(level_[msg.sender] > 0, "Can't buy with this level");

		uint256 price = 0.0001 ether;
		require(msg.value >= price, "Not enough eth sent, minimum buy: 1 token");

		uint256 ratio = level_[msg.sender].mul(1000);

		uint256 beforeBalance = ERC20.balanceOf(msg.sender);
		_mint(msg.sender, ratio.mul(msg.value));
		uint256 afterBalance = ERC20.balanceOf(msg.sender);

		earned_ += msg.value;

		return afterBalance > beforeBalance;
	}

	function whiteListUser(address customerAddress) external {
		require(owner_ == msg.sender);
		whitelist_[customerAddress] = true;
	}

	function unWhiteListUser(address customerAddress) external {
		require(owner_ == msg.sender);
		whitelist_[customerAddress] = false;
	}

	function isCustomerWhiteListed(address customerAddress) override external returns (bool){
		return whitelist_[customerAddress];
	}

	function setUserLevel(address customerAddress, uint256 level) external {
		require(owner_ == msg.sender, "Only owner can call this function");
		level_[customerAddress] = level;
	}

	function customerTierLevel(address customerAddress) override external returns (uint256){
		return level_[customerAddress];
	}
  
	function exit() external payable {
		require(owner_ == msg.sender);
		owner_.transfer(earned_);
	}
}