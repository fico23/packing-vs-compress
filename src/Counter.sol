// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibBytes} from "lib/solady/src/utils/LibBytes.sol";

contract Counter {
    struct SomeStructRaw {
        uint256 one;
        uint256 two;
        uint256 three;
        uint256 four;
        uint256 five;
        uint256 six;
        uint256 seven;
        uint256 eight;
    }

    struct SomeStructPacked {
        uint32 one;
        uint32 two;
        uint32 three;
        uint32 four;
        uint32 five;
        uint32 six;
        uint32 seven;
        uint32 eight;
    }

    SomeStructPacked public someStructPacked;
    

    function _storeStructCompressed(LibBytes.BytesStorage storage $, TokenPeriodSpend memory spend) internal {
        LibBytes.set($, LibZip.cdCompress(abi.encode(spend)));
    }

    /// @dev Loads the spend struct.
    function _loadStructCompressed(LibBytes.BytesStorage storage $)
        internal
        view
        returns (TokenPeriodSpend memory spend)
    {
        bytes memory compressed = LibBytes.get($);
        if (compressed.length != 0) {
            bytes memory decoded = LibZip.cdDecompress(compressed);
            assembly ("memory-safe") {
                spend := add(decoded, 0x20) // Directly make `spend` point to the decoded.
            }
        }
    }
}
