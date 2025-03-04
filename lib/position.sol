// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

library Position{
    
    struct Info{
        uint128 liquidity;
    }
    

    /**
     * 
     * @param self Refers to the struct Info stored in contract storage. 
     * This struct holds data about the liquidity position
     * @param liquidityDelta The change in liquidity – this value is added to the existing liquidity.
     */

    function update(
        Info storage self, 
        uint128 liquidityDelta) internal { 
            
            // Retrieves the current liquidity from the position struct
            uint128 liquidityBefore = self.liquidity;
            // Adds the liquidity Change or liquidityDelta to current liquidity
            uint128 liquidityAfter = liquidityBefore+liquidityDelta;
            
            // Storing the updated value
            self.liquidity = liquidityAfter;
    }

    /**
     * 
     * @param self Reference to mapping that stores positions info
     * @param owner Address of the Liquidity Provider who owns the position
     * @param lowerTick Represents the lower bound of the range
     * @param upperTick Represents the upper bound of the range
     */

    function get(
        mapping (bytes32=>Info) storage self,
        address owner,
        int24 lowerTick,
        int24 upperTick
    ) internal view returns(Position.Info storage position) {
        
        /**
         * Each position is uniquely identified by three keys: owner address, lower tick index, and upper tick index. 
         * We hash the three to make storing data cheaper: when hashed, every key will take 32 bytes, instead of 96 bytes
         * when owner, lowerTick, and upperTick are separate keys.
         */

        position = self[keccak256(abi.encodePacked(owner, lowerTick, upperTick))];
    }
}

