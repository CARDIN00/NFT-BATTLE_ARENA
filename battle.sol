// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "./reward.sol";
import "./NFT.sol";

contract ballteArena{
    NFTmanager public NFT;
    RewardManager public Rewards;
    uint public  battleCounter;

    struct battle{
        uint[] participants; //id registered for battle
        mapping (uint => address) nftOwner;
        address winner;
        uint reward;
        bool isCompleted;
    }

    constructor(address _nft, address _RewardManager){
        NFT = NFTmanager(_nft);
        Rewards = RewardManager(_RewardManager);
    }

    mapping (uint => battle)public Battles;
    mapping (uint => bool)public nftInBattle;//is the nft is already in battle a


    event BattleExecuted(uint256 auctionId, address winner);
    event BattleCreated(uint auctionId,  address owner);
    event NFTRegistered(uint indexed battleId, uint nftId, address indexed owner);

    // FUNCTIONS

    
    function registerForBattle(uint auctionId, uint nftId)external {
        battle storage fight = Battles[auctionId];

        require(fight.isCompleted == false);
        require(msg.sender == NFT.getNftOwner(nftId),"Only Owner may register");
        for(uint i =0; i <fight.participants.length ; i++){
            require(nftInBattle[nftId] == false,"Already registered for a battle");
        }
        //register nft id for battle
        fight.participants.push(nftId);
        fight.nftOwner[nftId] = msg.sender;

        emit NFTRegistered(auctionId, nftId, msg.sender);
        
    }

    function createBattle(uint auctionId) external  {
        require(msg.sender == address(NFT),"Not authorized");
        require(Battles[auctionId].participants.length == 0,"battle already exists");  

        battle storage fight = Battles[auctionId];
        fight.isCompleted = false;
        emit BattleCreated(auctionId,  msg.sender);  
    }

    // BATTLE LOGIC
    function simulateBattle(uint[] memory nftId)internal view returns (uint){
        // Use a simple randomness mechanism for now (e.g., blockhash)
        uint randomHash = uint(keccak256(abi.encodePacked(block.timestamp,block.prevrandao,nftId)));
        return randomHash % nftId.length;//rturn index of the winning nft
    }

    function exicuteBattle(uint auctionId)external {
        battle storage fight = Battles[auctionId];

        require(fight.isCompleted == false);
        require(fight.participants.length > 2,"not enough participants");

        uint winnerIndex = simulateBattle(fight.participants);
        uint winnerNFTId = fight.participants[winnerIndex];
        address winner = fight.nftOwner[winnerNFTId];

        fight.winner = winner;
        fight.isCompleted = true;

        
        // uint rewardAmount = BattleReward[auctionId];
        //emit BattleExecuted(auctionId, winner, rewardAmount);

        emit BattleExecuted(auctionId, winner);
    }
}