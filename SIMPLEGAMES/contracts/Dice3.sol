// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Dice3 {
  address public manager;
  address payable[] public players;

  modifier onlyManager() {
    require(manager==msg.sender, "Доступ запрещен!");
    _;
  }
  constructor () public {
    manager = msg.sender;
  }


  function CEO() public {
    manager = msg.sender;
  }

  function Enter() public payable returns(uint) {
    require(msg.value > .001 ether, "Ставка слишком мала!");
    players.push(msg.sender);
  }

  function getRandomNumber(uint number) private view returns(uint) {
    uint brosok = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, number))) % 10;
    brosok = brosok + 2;
    return(brosok);
  }
  function Winner() public payable restricted returns (string memory, uint, uint) {
    uint player1 = getRandomNumber(0);
    uint player2 = getRandomNumber(1);
    if(player1 > player2) {
      players[0].transfer(address(this).balance);
      return("Победил игрок 1", player1, player2);
    }
  
    else if(player1 > player2) {
      players[1].transfer(address(this).balance);
      return("Победил игрок 2", player1, player2);
    }
      
    else 
      return("Ничья, ваши ставки сгорели", player1, player2);
  }
  modifier restricted () {
    require(msg.sender == manager, "Нет доступа");
    _;
  }
}

