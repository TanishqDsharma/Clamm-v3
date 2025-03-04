// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "../lib/TickMath.sol";


library tick{
   struct Info{
    bool initialized;
    uint128 liquidity;
   }

   function update(
      mapping(int24=>tick.Info) storage self,
      int24 Tick,
      uint128 liquidityDelta
   ) internal 
   {
      tick.Info storage tickInfo = self[Tick];
      uint128 liquidityBefore= tickInfo.liquidity;
      uint128 liquidityAfter= liquidityBefore + liquidityDelta;

      if(liquidityBefore==0){
         tickInfo.initialized = true;
      }

      tickInfo.liquidity=liquidityAfter;

   }



}

