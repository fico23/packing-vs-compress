// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

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

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
