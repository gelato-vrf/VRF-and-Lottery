// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILottery {
    function startLottery() external;

    function enter() external payable;

    function pickWinner() external;

    function getPlayers() external view returns (address[] memory);

    function getLotteryTimes()
        external
        view
        returns (uint256 startTime, uint256 endTime, address managerAddress);

    event LotteryStarted(uint256 startTime, uint256 endTime);
    event WinnerSelected(address indexed winner, uint256 amount);
    event LotteryEnded(address indexed winner, uint256 amount);
}
