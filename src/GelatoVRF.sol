// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VRF {
    uint256 private rng;
    address public gelatoOp;
    uint256 public lastUpdate;
    bool initOperator;

    function setGelatoOperator(address _gelatoOp) external {
      require(!initOperator, "gelatoOp already initialized");
      gelatoOp = _gelatoOp;
      initOperator = true;
    }

    function setRandom(uint256 _rng) external {
        require(msg.sender == gelatoOp, "caller is not the gelato operator");
        rng = _rng;
        lastUpdate = block.timestamp;
    }

    function getRandom(string calldata space) external view returns (uint256) {
        require(initOperator, "gelatoOp not initialized");

        bytes memory concat = abi.encodePacked(space, rng);
        uint256 hash = uint256(keccak256(concat));
        return hash;
    }
}
