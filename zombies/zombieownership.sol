// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./zombieattack.sol";
import "../tokencontracts/erc721.sol";


contract ZombieOwnership is ZombieAttack {

    mapping (uint => address) zombieApprovals;

    function balanceOf(address _owner) external view returns (uint256) {
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        return zombieToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        SafeMath.add(ownerZombieCount[_to], 1);
        SafeMath.sub(ownerZombieCount[_from], 1);
        zombieToOwner[_tokenId] = _to;
        emit ERC721.Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require(zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);

    }

     function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
        zombieApprovals[_tokenId] = _approved;
        emit ERC721.Approval(msg.sender, _approved, _tokenId);
    }
}