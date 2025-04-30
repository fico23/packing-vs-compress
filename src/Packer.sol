// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibBytes} from "solady/utils/LibBytes.sol";
import {LibZip} from "solady/utils/LibZip.sol";

contract Packer {
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

    LibBytes.BytesStorage public someStructPacked;

    function readStructRaw() public view returns (SomeStructRaw memory) {
        return _loadStructCompressed(someStructPacked);
    }

    function writeStructRaw(SomeStructRaw memory someStructRaw) public {
        _storeStructCompressed(someStructPacked, someStructRaw);
    }

    function _storeStructCompressed(LibBytes.BytesStorage storage $, SomeStructRaw memory someStructRaw) internal {
        bytes memory encoded = new bytes(256);
        assembly ("memory-safe") {
            mcopy(add(encoded, 0x20), someStructRaw, 256)
        }

        LibBytes.set($, LibZip.cdCompress(encoded));
    }

    /// @dev Loads the spend struct.
    function _loadStructCompressed(LibBytes.BytesStorage storage $)
        internal
        view
        returns (SomeStructRaw memory someStructRaw)
    {
        bytes memory compressed = LibBytes.get($);
        if (compressed.length != 0) {
            bytes memory decoded = LibZip.cdDecompress(compressed);
            assembly ("memory-safe") {
                someStructRaw := add(decoded, 0x20) // Directly make `spend` point to the decoded.
            }
        }
    }
}
