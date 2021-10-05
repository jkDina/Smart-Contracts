// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract RSP {
    struct bet {
        uint gameNumber;
        uint8 playerNumber;
        uint256 value;
        address payable addr;
        bool isSet;
    }
    address admin;
    uint public counter;
    mapping(uint => address[2]) public games;
    mapping(uint => bool) gamesToClosed;
    
    mapping(uint => bet[]) public bets;
    mapping(uint => mapping(address => bool)) staked;
    
    mapping(uint8 => string) private numValueToName;
    
    event Log(
      uint reward,
      uint money
    );
    
    event Log2(
        string s
    );
    
    constructor() {
        counter = 0;
        admin = msg.sender;
        
        numValueToName[0] = 'rock';
        numValueToName[1] = 'scissors';
        numValueToName[2] = 'paper';
    }
    
    function addPlayer() public {
        games[counter / 2][counter % 2] = msg.sender;
        counter++;
    }
    
    function setBet(uint gameNumber, uint8 playerNumber) public payable {
        require(playerNumber == 0 || playerNumber == 1, 'Not correct the player number!');
        require(!staked[gameNumber][msg.sender]);
        require(msg.value > 0, 'You have to stake a not zero value');
        
        bets[gameNumber].push(bet({
            gameNumber: gameNumber,
            playerNumber: playerNumber,
            value: msg.value,
            addr: payable(msg.sender),
            isSet: true
        }));
        staked[gameNumber][msg.sender] = true;
    }
    
    function checkGameReady(uint num) public view returns (bool) {
        return games[num][0] != address(0) && games[num][1] != address(0);
    }
    
    function abs(int8 x) private pure returns (int8) {
        return x >= 0 ? x : -x;
    }
    
    function compare(uint8 val1, uint8 val2) private pure returns(int8) {
        int8 diff = int8(val1) - int8(val2);
        
        if (diff == 0) {
            return 0;
        }
        
        bool isReversed = val1 + val2 == 2 && val1*val2 == 0;
        
        int8 result = diff / abs(diff) * (isReversed ? -1 : int8(1));
        
        return result;
    }
    
    function defineWinner(uint number) public view returns(string memory s1, string memory s2, address winner) {
        require(msg.sender == admin, 'not allowed');
        require(!gamesToClosed[number], 'game have already been closed');
        
        uint8 val1 = uint8(uint256(keccak256(abi.encodePacked(block.timestamp, admin))) % 3);
        uint8 val2 = uint8(uint256(keccak256(abi.encodePacked(block.timestamp))) % 3);
    
        s1 = numValueToName[val1];
        s2 = numValueToName[val2];
        
        int8 winnerVal = compare(val1, val2);
        if (winnerVal > 0) {
            winner = games[number][1];
        } else if (winnerVal < 0) {
            winner = games[number][0];
        } else {
            winner = address(0);
        }
        
    }
    
    function closeGame(uint gameNumber, uint8 winnerNumber) public payable {
        gamesToClosed[gameNumber] = true;
        
        uint wagerWinnerAmount = 0;
        uint money = 0;

        for (uint i = 0; i < bets[gameNumber].length; i++) {
            bet memory b = bets[gameNumber][i];
            
            if (b.playerNumber == winnerNumber) {
                wagerWinnerAmount++;
            }
            money += b.value;
        }
        
        uint reward = money / wagerWinnerAmount;
        
        emit Log({
            reward: reward,
            money: money
        });
        
        for (uint i = 0; i < bets[gameNumber].length; i++) {
            bet memory b = bets[gameNumber][i];
            
            if (b.playerNumber == winnerNumber) {
                b.addr.transfer(reward);
                emit Log2("ok!");
            }
        }
    }
}

