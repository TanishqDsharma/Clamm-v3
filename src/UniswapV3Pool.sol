// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.16;

import "../lib/Tick.sol";
import "../lib/position.sol";

contract UniswapV3Pool{

using tick for mapping(int24 => tick.Info);
using Position for mapping(bytes32 => Position.Info);
using Position for Position.Info;


error invalidTickRange();
error zeroLiquidity();

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


amount0 = 0.998976618347425280 ether;
amount1 = 5000 ether;

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

/**
 * 
 * @param token0_ The address of token0 in the pair
 * @param token1_ The address of token1 in the pair
 * @param sqrtPX96 The initial square root price of token1 in terms of token0, scaled by 2^96
 * @param inital_tick The corresponding tick index for the given sqrtPX96
 */

constructor(address token0_, 
            address token1_, 
            uint160 sqrtPX96, 
            int24 inital_tick){
                    token0 = token0_;
                    token1 = token1_; 
                    slot0 = Slot0({sqrtPriceX96: sqrtPX96, tick: inital_tick});
    }


/**
 * 
 * @param owner Address of the owner to track the liquidity
 * @param lowertick defines the lower range of the price
 * @param uppertick defines the upper range of the price
 * @param amount  The amount of liquidity want to provide
 * @return amount0 Returns required amount of token0
 * @return amount1 Returns required amount of token1
 */


function mint(
    address owner,
    int24 lowertick,
    int24 uppertick,
    uint128 amount) external returns (uint256 amount0,uint256 amount1){


    // Price Range Checks
    if(lowertick>=uppertick||lowertick<MIN_TICK||uppertick>MAX_TICK){
        revert invalidTickRange();
        }

    // Checking the amount of liquidity should not be zero
    if(amount==0){
        revert zeroLiquidity(); 
    }
    
    // Updating the ticks mapping for both lower and upper range
    ticks.update(lowertick,amount);
    ticks.update(uppertick,amount);


    // Updating the positions mapping
    Position.Info storage position = positions.get(owner, lowertick, uppertick);
    position.update(amount);


    uint256 balance0Before;
    uint256 balance1Before;

    // First we get the current Token balances
    if (amount0 > 0) balance0Before =    balance0();
    if (amount1 > 0) balance1Before =    balance1();


    //Then we call the uniswapV3MintCallback method on the caller–this is the callback. It’s expected that the caller 
    // (whoever calls mint) is a contract because non-contract addresses cannot implement functions in Ethereum

    IUniswapV3callback(msg.sender).uniswapV3mintCallback(amount0, amount1);

    // Then we call the uniswapV3MintCallback method on the caller–this is the callback. It’s expected that the caller 
    // (whoever calls mint) is a contract because non-contract addresses cannot implement functions in Ethereum
    if (amount0 > 0 && balance0Before + amount0 > balance0())
        revert InsufficientInputAmount();
    
    if (amount1 > 0 && balance1Before+amount1>balance1())
        revert InsufficientInputAmount();


    emit Mint(msg.sender, owner, lowerTick, upperTick, amount, amount0, amount1);


}


function balance0() internal returns(uint256 balance) {

    

}

function balance1() internal returns(uint256 balance) {

}
    
}



















