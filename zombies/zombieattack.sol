// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    uint randNonce = 0;
    uint attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        SafeMath.add(randNonce, 1);
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
    }

    function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
        if(rand <= attackVictoryProbability) {
            SafeMath.add(myZombie.winCount, 1);
            SafeMath.add(myZombie.level, 1);
            SafeMath.add(enemyZombie.lossCount, 1);
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombies");
        }
        else{
            SafeMath.add(myZombie.lossCount, 1);
            SafeMath.add(enemyZombie.winCount, 1);
            _triggerCooldown(myZombie);
        }
    }
}
