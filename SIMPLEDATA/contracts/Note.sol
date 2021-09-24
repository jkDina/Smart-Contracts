// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Note {
  string public name;
  uint number;
  string public adress;
  /*constructor() public {
  }*/
  function set(string memory newName, uint newNumber, string memory newAdress) public {
    name = newName;
    number = newNumber;
    adress = newAdress;
  }
  function get() public view returns (string memory, uint, string memory) {
    return (name, number, adress);
  }
}
