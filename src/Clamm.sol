// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;


import "../lib/Tick.sol";
contract CLAMM {

// token0 and token1 are the tokens that will be deposited in the pool
address public immutable token0;
address public immutable token1;

// fee is the fees on swaps
uint24 public immutable fee;

//
int24 public immutable tickspacing;

uint128 public immutable  maxLiquidityPerTick;



constructor(
    address _token0,
    address _token1,
    uint24 _fee,
    int24 _tickspacing){

    token0 = _token0;
    token1 = _token1;
    fee = _fee;
    tickspacing = _tickspacing;

    maxLiquidityPerTick = tick.tickSpacingToMaxLiquidityPerTick(_tickspacing);
}   




















}