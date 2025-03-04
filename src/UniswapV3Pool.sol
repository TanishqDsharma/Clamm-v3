// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.16;

import "../lib/Tick.sol";
import "../lib/position.sol";

contract UniswapV3Pool{

using tick for mapping(int24 => tick.Info);
using Position for mapping(bytes32 => Position.Info);
using Position for Position.Info;


int24 internal constant MIN_TICK = -887272;
int24 internal constant MAX_TICK = -MIN_TICK;



/**
 * @notice Each Pool is tied to exactly two tokens. Token addresses are set at deployment and cannot change. 
 * The contract store addresses of two tokens and these addresses are immutables
 */

address public immutable token0;
address public immutable token1;


struct Slot0 {
    // Current sqrt(P)
        uint160 sqrtPriceX96;
        // Current tick
        int24 tick;
}

Slot0 public slot0;

// Amount of liquidity, L.
uint128 public liquidity;

/**
 * Ticks info : Each Pool contract also need to maintain a ticks registry, this will be a mapping between ticks 
 * indexes and structs storing ticks info 
 */
mapping(int24 => tick.Info) public ticks;

/** 
 * Positions info: Each Pool contract is a collection of multiple Liquidity Positions where each position
 * represents an LP's deposites assets within a specific price range.
*/


mapping(bytes32 => Position.Info) public positions;

    constructor(address token0_, 
                address token1_, 
                uint160 sqrtPX96, 
                int24 inital_tick){
                    token0 = token0_;
                    token1 = token1_; 
                    slot0 = Slot0({sqrtPriceX96: sqrtPX96, tick: inital_tick});
    }
    
}



















