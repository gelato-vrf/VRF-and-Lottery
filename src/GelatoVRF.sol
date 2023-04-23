// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Errors} from "./Errors.sol";

contract VRF {
    uint256 private rng;
    address public gelatoOp;
    uint256 public lastUpdate;
    bool initOperator;

    function setGelatoOperator(address _gelatoOp) external {
        if (initOperator) revert Errors.OperatorAlreadySet();
        gelatoOp = _gelatoOp;
        initOperator = true;
    }

    function setRandom(uint256 _rng) external {
        if (msg.sender != gelatoOp) revert Errors.CallerIsNotOperator();
        rng = _rng;
        lastUpdate = block.timestamp;
    }

    function getRandom(string calldata space) external view returns (uint256) {
        if (!initOperator) revert Errors.OperatorNotSet();

        bytes memory concat = abi.encodePacked(space, rng);
        uint256 hash = uint256(keccak256(concat));
        return hash;
    }
}
