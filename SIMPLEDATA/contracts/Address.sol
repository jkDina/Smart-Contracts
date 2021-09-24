// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Address {
  mapping(uint=>address) addresses;
  uint Count;
  function set(address userAddress) public {
    addresses[Count] = userAddress;
    Count++;
  }  
  function get(address userAddress) public view returns (uint) {
    for (uint i = 0; i <= Count; i++) {
      if(addresses[i] == userAddress)
      return i;
    }
  }
  function getAll() public view returns (address[] memory) {
    address[] memory all = new address[](Count);
    for (uint i = 0; i < Count; i++) {
      all[i] = addresses[i];
    }
    return all;
  }
}
