/// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DragonFarm2 {
  event NewDragon(uint id, string name, uint dna);
  struct Dragon {
    uint id;
    string name;
    uint dna;
  }
  Dragon[] public dragons;
  mapping (uint => address)  public DragonOwner;
  mapping (address => uint) ownerDragons;

  function GenerateRandomDna(string memory _str) internal pure returns (uint) {
    uint rand = uint(keccak256((abi.encode(_str))));
    return rand % (10 **16);
  }
   
  function CreateDragon(string memory name) public {
    uint dna = GenerateRandomDna(name);
    uint id = ownerDragons[msg.sender];
    dragons.push(Dragon(id, name, dna));
    DragonOwner[id] = msg.sender;
    emit NewDragon(id, name, dna);
    ownerDragons[msg.sender]++;
  }
}