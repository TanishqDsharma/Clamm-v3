// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "../lib/TickMath.sol";


library tick{
   struct Info{
    bool initialized;
    uint128 liquidity;
   }

   /**
    * 
    * @param self This is the mapping where key is the tick Indexes and value is a 
    * struct of type `Tick.Info`
    * @param Tick Tick level that is getting updated
    * @param liquidityDelta  Amount of liquidity being added
    */

   function update(
      mapping(int24=>tick.Info) storage self,
      int24 Tick,
      uint128 liquidityDelta
   ) internal 
   {  
      
      // We are retreiving the ticks stored data 
      tick.Info storage tickInfo = self[Tick];

      // We are getting the current Liquidity of the tick
      uint128 liquidityBefore= tickInfo.liquidity;

      // We are getting the liquidty after the liquidityDelta is added to the tick
      uint128 liquidityAfter= liquidityBefore + liquidityDelta;

      if(liquidityBefore==0){
         tickInfo.initialized = true;
      }

      // storing the new liquidity in the mapping
      tickInfo.liquidity=liquidityAfter;

   }



}

