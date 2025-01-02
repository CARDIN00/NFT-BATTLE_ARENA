// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTmanager{
    //track the number of minted nft
    uint public nftCounter;

    //nft id => owner
    mapping (uint => address)public NftOwner;

    event NFTminted(uint nftId, address owner);
    event NFTtransfered(uint nftId, address from, address to);

    // FUNCTIONS
    function getNftOwner(uint nftId)external view returns (address){
        return NftOwner[nftId];
    }

    // for people to Mint their own new NFT
    function Mint()external returns (uint){
        uint nftId = nftCounter;
        NftOwner[nftId] = msg.sender;
        nftCounter++;

        emit NFTminted(nftId, msg.sender);
        return nftId;
    }

    function transferNFT(uint nftId, address to)external {
        require(msg.sender == NftOwner[nftId],"Not NFT owner");
        require(to != address(0),"Not valid address");

        NftOwner[nftId] = to;
        emit NFTtransfered(nftId, msg.sender, to);
    }
}