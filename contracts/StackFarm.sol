// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "hardhat/console.sol";

 contract StackFarmb is Ownable {
    using SafeERC20 for ERC20;
    using SafeMath for uint256;

    address[] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    address public feeAddress = 0x3E4E4B61a2f4Fac6f9706f66A78aA9E01c78a5cb;


    uint256 public _taxFee = 1;
    ERC20 public usdt;
    ERC20 public  stackToken;

    constructor(ERC20 _stackToken, ERC20 _usdt) {
        usdt = ERC20(_usdt);
        stackToken = ERC20(_stackToken);
    }

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    function deposit(uint256 _amount) public {
        require(_amount > 0,"Invalid amount");

        uint256 value = (_amount /100) * _taxFee;
        usdt.safeTransferFrom(_msgSender(),address(this), _amount.sub(value));
        usdt.safeTransferFrom(_msgSender(), feeAddress, value);

        stakingBalance[_msgSender()] = stakingBalance[_msgSender()].add(_amount).sub(value);
        if(!hasStaked[_msgSender()]) stakers.push(_msgSender());
        isStaking[_msgSender()] = true;
        hasStaked[_msgSender()] = true;


        emit Deposit(_msgSender(), _amount.sub(value));
    }


    





 }