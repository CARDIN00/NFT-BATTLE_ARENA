# NFT-BATTLE_ARENA
Overview of the NFT Battle Arena:

The project enables users to participate in a bidding auction to acquire perks, advantages, and battle participation.
The platform allows players to register NFTs for battles, which are conducted based on randomized simulations.
Rewards are distributed to the winning NFT owners after completing the battle.
Auction Contract (AuctionContract):

Manages the auction process for battle participation and perks.
Users can place bids, and the highest bidder gets the opportunity to join the battle.
Refundable bids are handled if users are outbid.
Includes mechanisms for starting and ending auctions.
Battle Arena Contract (ballteArena):

Manages the registration of NFTs for battles.
Simulates battles based on the participants' NFTs and determines a winner.
Includes events for battle creation, registration, and execution.
NFT Management Contract (NFTmanager):

Allows users to mint their own NFTs and manage ownership.
Provides NFT transfer functionality between users.
Tracks the ownership of NFTs based on a unique NFT ID.
Reward Manager Contract (RewardManager):

Manages the reward pool for battle winners.
Allows for the deposit, allocation, and distribution of rewards after a battle.
The contract ensures only the owner can allocate and distribute rewards.
Event Handling:

All important actions (e.g., bid placement, battle execution, NFT transfer, reward distribution) trigger events.
Events are emitted for logging and tracking critical interactions on the platform.
Key Interactions & Functions:

Auction Start/End: Functions to start an auction, place bids, and end auctions.
Battle Registration: Allows NFTs to register for battles after being part of an auction.
Battle Simulation and Execution: Simulates the battle and determines the winner based on random selection.
NFT Minting and Transfers: Mint new NFTs and allow transfers between owners.
Reward Management: Allocates and distributes rewards based on battle outcomes.
Security Features:

Reentrancy protection when transferring funds.
Access control via the OnlyOwner modifier for sensitive functions like reward allocation.
Ensures only owners of NFTs can register them for battle.
