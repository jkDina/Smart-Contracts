// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Dice {
  function getRandomNumber(uint number) private view returns(uint) {
    uint brosok = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, number))) % 10;
    brosok = brosok + 2;
    return(brosok);
  }
  function Winner() public view returns (string memory, uint) {
    uint player1 = getRandomNumber(0);
    uint player2 = getRandomNumber(1);
    if(player1 > player2)
      return("Победил игрок 1", player1);
    else if(player1 > player2)
      return("Победил игрок 2", player2);
    else 
      return("Ничья", player1);
  }
}
