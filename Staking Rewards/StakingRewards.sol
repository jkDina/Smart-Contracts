/*
Основная идея контракта - вводить и выводить токены одного типа и
получать награду в виде токенов другого вида
(может быть и таким же при совпадении адресов двух типов токена в конструкторе).
Пользователь может делать три действия - вводить токены,
выводить их и получать награду.

При каждом из этих действий происходит перерасчет награды
за токен и она сохраянется в блокчейне(награда за токен).

Также при этом сохраняется и предполагаемая награда
пользователя в mapping 
(mapping rewards: адрес пользователя ==> предполагаемая суммарная награда одного пользователя в данный момент времени за все его токены)
и текущая версия его награды(mapping  userRewardPerTokenPaid: адрес пользователя ==> награда за 1 токен в данный момент времени).

в Функции rewardPerToken
Новая награда за токен (для всех пользователей)
рассчитывается как сумма текущей награды и слагаемого,
пропорционального разнице времен текущего минус прошлое
обновление награды за токен (для всех пользователей)
и обратно пропорционально числу всех токенов в контракте.
rewardPerTokenStored +(((block.timestamp - lastUpdateTime) * rewardRate * 1e18) / _totalSupply)

То есть чем больше имеем токенов, тем медленнее будет расти награда и наоборот.

А также, чем больше прошло времени с предыдущего обновления награды,
тем больше будет приращение награды за токен (для всех пользователей).
Записывается в переменную rewardPerTokenStored в модификаторе  updateReward

При каждом обновлении токенов (ввод, вывод, получение награды)
происходит перерасчет как глобальных (переменных смарт контракта)параметров награды
1)за токен (rewardPerTokenStored) 
2)и параметра времени прошлого обновления этой награды,(lastUpdateTime)

А также при каждом обновлении токенов (ввод, вывод, получение награды)
происходит  перерасчет параметров для каждого пользователя - 
1)его новая награда (rewards)
(есть прошлая награда + слагаемое*, пропорциональное разницы наград
за токен умноженной на баланс пользователя) 
2)и текущее значение награды за токен (userRewardPerTokenPaid) для этого пользователя.

*слагаемое, пропорциональное разницы наград за токен  = 
награда за токен, рассчитанная заново, минус старая награда именно для этого пользователя

*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract StakingRewards {
    IERC20 public rewardsToken;
    IERC20 public stakingToken;

    uint public rewardRate = 100;
    uint public lastUpdateTime;
    uint public rewardPerTokenStored;

    mapping(address => uint) public userRewardPerTokenPaid;
    mapping(address => uint) public rewards;

    uint private _totalSupply;
    mapping(address => uint) private _balances;

    constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }

    function rewardPerToken() public view returns (uint) {
        if (_totalSupply == 0) {
            return 0;
        }
        return
            rewardPerTokenStored +
            (((block.timestamp - lastUpdateTime) * rewardRate * 1e18) / _totalSupply);
    }

    function earned(address account) public view returns (uint) {
        return
            ((_balances[account] *
                (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) +
            rewards[account];
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        rewards[account] = earned(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }

    function stake(uint _amount) external updateReward(msg.sender) {
        _totalSupply += _amount;
        _balances[msg.sender] += _amount;
        stakingToken.transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(uint _amount) external updateReward(msg.sender) {
        _totalSupply -= _amount;
        _balances[msg.sender] -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }

    function getReward() external updateReward(msg.sender) {
        uint reward = rewards[msg.sender];
        rewards[msg.sender] = 0;
        rewardsToken.transfer(msg.sender, reward);
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}