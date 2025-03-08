// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;


import {Test} from "../lib/forge-std/src/Test.sol";
import {UniswapV3Pool} from "../src/UniswapV3Pool.sol";
import {ERC20mock} from "../test/mock/ERC20mock.sol";



contract uniswapV3PoolTest is Test {

ERC20mock token0;
ERC20mock token1;

struct TestCaseParams{
    uint256 wethBalance;
    uint256 usdcBalance;
    int24 currentTick;
    int24 lowerTick;
    int24 upperTick;
    uint128 liquidity;
    uint160 currentSqrtP;
    bool shouldTransferInCallback;
    bool mintLiquidity;
}

    function setUp() external {
        token0 = new ERC20mock("WETH","WETH",18);
        token1 = new ERC20mock("USDC","USDC",6);

    }


    function testMintSuccess() public{
        TestCaseParams memory params = TestCaseParams({
        wethBalance: 1 ether,
        usdcBalance: 5000 ether,
        currentTick: 85176,
        lowerTick: 84222,
        upperTick: 86129,
        liquidity: 1517882343751509868544,
        currentSqrtP: 5602277097478614198912276234240,
        shouldTransferInCallback: true,
        mintLiquidity: true
    });}

    function setupTestCase(TestCaseParams memory params) internal returns
        (uint256 poolBalance, uint256 poolBalance1)
    {
        token0.mint(address(this),params.wethBalance);
        token1.mint(address(this),params.usdcBalance);

        pool = new UniswapV3Pool(token0,token1,params.currentSqrtP,params.currentTick);

    }

    
}