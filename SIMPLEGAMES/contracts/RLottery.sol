// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RLottery {
  struct player{
    uint Num;
  }
  mapping(uint => player) public players;
  function getTickets(uint Num) public payable {
    require(Num <= 10, "Уже зарегистрировани 10 игроков!");
    players[Num] = player(Num);
  }
  function Winner() public view returns(string memory, uint) {
    uint  length = 10;
    uint index;
    uint randomnumber = uint(keccak256(abi.encodePacked(now, msg.sender, length))) % 9;
    randomnumber++;
    index = randomnumber % 10;
    return("Номер победителя", index);
  }
}




