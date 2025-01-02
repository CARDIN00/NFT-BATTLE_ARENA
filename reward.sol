// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RewardManager{
    address public Owner;
    uint public rewardPool;
    constructor(){
        Owner = msg.sender;
    }

    //battle Id => rewardamount
    mapping(uint => uint)public BattleReward;

    modifier OnlyOwner(){
        require(msg.sender == Owner);
        _;
    }
    
    
    event rewarDeposited(address indexed sender, uint amount);
    event rewardAllocated(uint indexed battleId,uint amount);
    event rewardDistributed(uint indexed battleId, address indexed winner,uint rewarAmount);

    // FUNCTIONS
    function depositeReward(uint amount)external payable {
        require(msg.value >0);
        rewardPool += msg.value;
        emit rewarDeposited(msg.sender, amount);
    }
    
    function allocateReward(uint battleId, uint rewardAmount)external OnlyOwner{
        require(rewardAmount<= rewardPool,"Not enough in Pool");
        require(BattleReward[battleId] == 0,"Already Allocated");

        BattleReward[battleId] = rewardAmount;
        rewardPool -= rewardAmount;
        emit rewardAllocated(battleId, rewardAmount);
    }

    function distributeReward(uint battleId, address winner)external OnlyOwner{
        uint rewardAmount = BattleReward[battleId];
        require(rewardAmount > 0,"No reward allocated");

        BattleReward[battleId] = 0;
        (bool success,) = winner.call{value: rewardAmount}("");
        require(success,"transfer failed");
        
        emit rewardDistributed(battleId, winner, rewardAmount);
    }


}