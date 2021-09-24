pragma solidity >=0.4.22 <0.9.0;

contract Fibonachi {
  function getValue(uint256 index) public pure returns (uint256) {
    uint256 res;
    uint256 prevNumber = 0;
    uint256 number = 1;
    if (index == 0) {
      return prevNumber;
    } else if (index == 1) {
      return number;
    }
    for (uint256 i = 0; i <= index - 2; i++) {
      res = number + prevNumber;
      prevNumber = number;
      number = res;
    }
    return res;
  }
}
