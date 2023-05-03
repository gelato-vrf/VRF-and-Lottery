// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "src/GelatoVRF.sol";

abstract contract RandomnessConsumer {
	VRF immutable private _randomnessProvider;
	uint256 private _seed;
	uint256 private _randCounter;

	constructor(VRF randomnessProvider) {
		_randomnessProvider = randomnessProvider;
	}

	modifier withRandomness {
		_seed = _randomnessProvider.getRandom("");
		_randCounter = 0;
		_;
		_seed = 0;
	}

	function random() internal returns (uint256) {
		// developers must ensure the PRNG is seeded when drawing random numbers
		assert(_seed != 0);
		return uint256(sha256(abi.encode(_seed, _randCounter++)));
	}
}
