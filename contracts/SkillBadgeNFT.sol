// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SkillBadgeNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    mapping(uint256 => address) public sessionToLearner;

    event BadgeMinted(address indexed learner, uint256 indexed tokenId, string tokenURI);

    constructor() ERC721("SkillBadge", "SKLBDG") Ownable(msg.sender) {}

    function mintBadge(address learner, string memory tokenURI) external onlyOwner returns (uint256) {
        require(learner != address(0), "Invalid learner address");

        uint256 tokenId = ++nextTokenId;
        _safeMint(learner, tokenId);
        _setTokenURI(tokenId, tokenURI);

        sessionToLearner[tokenId] = learner;

        emit BadgeMinted(learner, tokenId, tokenURI);
        return tokenId;
    }

    function badgesOwned(address user) external view returns (uint256[] memory) {
        uint256 total = nextTokenId;
        uint256 count = 0;

        for (uint256 i = 1; i <= total; i++) {
            if (ownerOf(i) == user) count++;
        }

        uint256[] memory result = new uint256[](count);
        uint256 j = 0;

        for (uint256 i = 1; i <= total; i++) {
            if (ownerOf(i) == user) {
                result[j] = i;
                j++;
            }
        }

        return result;
    }
}
