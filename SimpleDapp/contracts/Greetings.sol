// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Greetings {
 string greeting  = "Hello world!";
 function greet() public view returns (string memory) {
   return greeting;
 }

 function setGreeting(string memory _greeting) public returns (bool) {
   greeting = _greeting;
   return true;
 }
}
