// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lottery.sol";

contract LotteryTest is Test {
    Lottery public lottery;

    function setUp() public {
        lottery = new Lottery(1 hours, 1 ether);
    }

    function testStartLottery() public {
        lottery.startLottery();
        assertEq(lottery.state(), Lottery.LotteryState.RUNNING);
    }
}
