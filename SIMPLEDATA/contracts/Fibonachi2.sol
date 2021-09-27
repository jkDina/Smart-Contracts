// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
contract Fibonachi2 {
    function calculateNumbers(uint256 amount) public pure returns (uint[] memory) {
        require(amount < 100, "Значение слишком велико 😃!");
        uint[] memory numbers = new uint[](amount);
        
        uint256 prevNumber = 0;
        uint256 number = 1;
        
        if (amount > 0) {
            numbers[0] = prevNumber;
        }
        
        if (amount > 1) {
            numbers[1] = number;
        }
        
        if (amount > 2) {
            for (uint256 i = 0; i < amount - 2; i++) {
                numbers[i + 2] = number + prevNumber;
                prevNumber = number;
                number = numbers[i + 2];
            }
        }
        
        return numbers;
    }
    
    
    function calculateSum(uint amount) public pure returns (uint) {
        uint[] memory numbers = calculateNumbers(amount);
        uint sum = 0;
        for (uint i = 0; i < amount; i++) {
            sum += numbers[i];
        }
        return sum;
    }
    
    function get() public view returns (uint) {
        uint length = 10;
        uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, length))) % 9;
        randomnumber++;
        return randomnumber;
    }
}