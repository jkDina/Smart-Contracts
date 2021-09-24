// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Calculator {
  function getCalk(uint256 x, bytes32 oper, uint256 y) public pure returns (uint256){
    uint256 res;
    if (oper == "+") res = x + y;
    if (oper == "-") res = x - y;
    if (oper == "*") res = x * y;
    if (oper == "/") res = x / y;
    return res;
  }
}
