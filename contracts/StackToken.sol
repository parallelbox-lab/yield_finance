// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract  StackToken is ERC20 {
    constructor() ERC20("StackToken","ST") {
      _mint(msg.sender, 10000 *10 ** decimals());
    }
}