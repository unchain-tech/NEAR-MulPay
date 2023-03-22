// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// Import this file to use console.log
import 'hardhat/console.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract SwapContract {
  address public deployerAddress;

  constructor() payable {
    deployerAddress = msg.sender;
  }

  // calculate value between two tokens
  function calculateValue(
    address tokenSendAddress,
    address tokenReceiveMesureAddress
  ) public view returns (uint256 value) {
    value =
      ((1 ether) * IERC20(tokenSendAddress).balanceOf(address(this))) /
      ERC20(tokenReceiveMesureAddress).balanceOf(address(this));
  }

  // distribute token to users
  function distributeToken(
    address tokenAddress,
    uint256 amount,
    address recipientAddress
  ) public {
    require(
      msg.sender == deployerAddress,
      'Anyone but deployer can distribute token!'
    );
    IERC20 token = IERC20(tokenAddress);
    token.transfer(recipientAddress, amount);
  }

  // swap tokens between two users
  function swap(
    address sendTokenAddress,
    address measureTokenAddress,
    address receiveTokenAddress,
    uint256 amount,
    address recipientAddress
  ) public payable {
    IERC20 sendToken = IERC20(sendTokenAddress);
    IERC20 receiveToken = IERC20(receiveTokenAddress);

    uint256 sendTokenValue = calculateValue(
      sendTokenAddress,
      measureTokenAddress
    );
    uint256 receiveTokenValue = calculateValue(
      receiveTokenAddress,
      measureTokenAddress
    );
    uint256 sendAmount = (amount * sendTokenValue) / (1 ether);
    uint256 receiveAmount = (amount * receiveTokenValue) / (1 ether);

    require(
      sendToken.balanceOf(msg.sender) >= sendAmount,
      'Your asset is smaller than amount you want to send'
    );
    require(
      receiveToken.balanceOf(address(this)) >= receiveAmount,
      'Contract asset of the currency recipient want is smaller than amount you want to send'
    );

    sendToken.transferFrom(msg.sender, address(this), sendAmount);
    receiveToken.transfer(recipientAddress, receiveAmount);
  }
}
