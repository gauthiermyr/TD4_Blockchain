pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ExerciceSolution.sol";
import "./Evaluator.sol";

contract AllInOne {


    ExerciceSolution public myToken_;
    Evaluator public evaluator_;
    address public contractAddress_;
    address public owner_;


    constructor(address payable evaluatorAddress) public {
        evaluator_ = Evaluator(evaluatorAddress);
        contractAddress_ = address(this);
        owner_ = msg.sender;
    }

    fallback () external payable 
	{}

	receive () external payable 
	{}

    function ex1() external returns(bool) {
        evaluator_.ex1_getTickerAndSupply();
        string memory ticker = evaluator_.readTicker(contractAddress_);
        uint256 supply = evaluator_.readSupply(contractAddress_);

        myToken_ = new ExerciceSolution(ticker, "@gauthiermyr", supply);
        evaluator_.submitExercice(myToken_);
        return true;
    }

    function ex2() external returns(bool) {
        evaluator_.ex2_testErc20TickerAndSupply();
        return true;
    }

    function ex3() external returns(bool) {
        myToken_.whiteListUser(address(evaluator_));
        myToken_.setUserLevel(address(evaluator_), 1);
        evaluator_.ex3_testGetToken();
        return true;
    }

    function ex4() external returns(bool) {
        evaluator_.ex4_testBuyToken();
        return true;
    }

    function ex5() external returns(bool) {
        myToken_.unWhiteListUser(address(evaluator_));
        myToken_.setUserLevel(address(evaluator_), 0);
        evaluator_.ex5_testDenyListing();
        return true;
    }

    function ex6() external returns(bool) {
        myToken_.whiteListUser(address(evaluator_));
        evaluator_.ex6_testAllowListing();
        return true;
    }

    function ex7() external returns(bool) {
        myToken_.unWhiteListUser(address(evaluator_));
        myToken_.setUserLevel(address(evaluator_), 0);
        evaluator_.ex7_testDenyListing();
        return true;
    }

    function ex8() external returns(bool) {
        myToken_.whiteListUser(address(evaluator_));
        myToken_.setUserLevel(address(evaluator_), 1);
        evaluator_.ex8_testTier1Listing();
        return true;
    }

    function ex9() external returns(bool) {
        myToken_.setUserLevel(address(evaluator_), 2);
        evaluator_.ex9_testTier2Listing();
        return true;
    }

    function execute() external {
        require(owner_ == msg.sender);

        bool ok = true;
        try this.ex1() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex1 failed");

        try this.ex2() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex2 failed");

        try this.ex3() returns (bool v) 
		{
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex3 failed");

        try this.ex4() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex4 failed");

        try this.ex5() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex5 failed");

        try this.ex6() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex6 failed");

        try this.ex7() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex7 failed");

        try this.ex8() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex8 failed");

        try this.ex9() returns (bool v) {
			ok = v;
        } 
        catch {
            ok = false;
        }
        require(ok, "ex9 failed");

        myToken_.exit();
    }
}