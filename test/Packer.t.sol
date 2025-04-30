// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Packer} from "../src/Packer.sol";
import {PackerOld} from "../src/PackerOld.sol";
contract PackerTest is Test {
    Packer public packer;
    PackerOld public packerOld;

    function setUp() public {
        packer = new Packer();
        packerOld = new PackerOld();
    }

    function test_readStructRaw() public {
        Packer.SomeStructRaw memory someStructRaw = Packer.SomeStructRaw({
            one: 1,
            two: 2,
            three: 3,
            four: 4,
            five: 5,
            six: 6,
            seven: 7,
            eight: 8
        });

        packer.writeStructRaw(someStructRaw);
        vm.snapshotGasLastCall("readStructRaw - write");
        Packer.SomeStructRaw memory readStructRaw = packer.readStructRaw();
        vm.snapshotGasLastCall("readStructRaw - read");
        assertEq(readStructRaw.one, someStructRaw.one);
        assertEq(readStructRaw.two, someStructRaw.two);
        assertEq(readStructRaw.three, someStructRaw.three);
        assertEq(readStructRaw.four, someStructRaw.four);
        assertEq(readStructRaw.five, someStructRaw.five);
        assertEq(readStructRaw.six, someStructRaw.six);
        assertEq(readStructRaw.seven, someStructRaw.seven);
        assertEq(readStructRaw.eight, someStructRaw.eight);
    }

    function test_readStructPacked() public {
        PackerOld.SomeStructPacked memory someStructPacked = PackerOld.SomeStructPacked({
            one: 1,
            two: 2,
            three: 3,
            four: 4,
            five: 5,
            six: 6,
            seven: 7,
            eight: 8
        });

        packerOld.writeStruct(someStructPacked);
        vm.snapshotGasLastCall("readStructPacked - write");
        PackerOld.SomeStructPacked memory readStructPacked = packerOld.readStruct();
        vm.snapshotGasLastCall("readStructPacked - read");
        assertEq(readStructPacked.one, someStructPacked.one);
        assertEq(readStructPacked.two, someStructPacked.two);
        assertEq(readStructPacked.three, someStructPacked.three);
        assertEq(readStructPacked.four, someStructPacked.four);
        assertEq(readStructPacked.five, someStructPacked.five);
        assertEq(readStructPacked.six, someStructPacked.six);
        assertEq(readStructPacked.seven, someStructPacked.seven);
        assertEq(readStructPacked.eight, someStructPacked.eight);
    }
}
