// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PackerOld {
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

    function readStruct() public view returns (SomeStructPacked memory) {
        return someStructPacked;
    }

    function writeStruct(SomeStructPacked memory someStructPacked_) public {
        someStructPacked = someStructPacked_;
    }
}
