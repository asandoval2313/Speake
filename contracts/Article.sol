// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Speake Article
/// @author Adrian Sandoval
/// @dev Not tested
contract Article is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event articlePublished(
        address indexed _publisher,
        uint256 _articleId,
        uint256 _timePublished
    );
    event donationMade(
        address _donator,
        uint256 _articleId,
        uint256 _amountDonated,
        address _token,
        string _donationType
    );

    address[] public donatableTokens; // Tokens readers can donate with

    constructor() ERC721("Article", "ART") {}

    /// @notice mints article and takes not of author and time minted
    function publishArticle(address publisher_) public returns (uint256) {
        uint256 newArticleId = _tokenIds.current();
        _mint(publisher_, newArticleId);
        uint256 timePublished = block.timestamp;

        _tokenIds.increment();
        emit articlePublished(publisher_, newArticleId, timePublished);
        return newArticleId;
    }

    /// @notice returns baseURI of token, storage handled by Arweave
    function _baseURI() internal pure override returns (string memory) {
        return "";
    }

    /// @notice burns token
    /// @dev required by openzeppelin
    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    /// @notice Returns tokenURI
    /// @dev required by openzeppelin
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
