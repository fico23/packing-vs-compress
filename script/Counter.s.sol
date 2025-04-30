// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Packer} from "../src/Packer.sol";

contract CounterScript is Script {
    Packer public packer;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        packer = new Packer();

        vm.stopBroadcast();
    }
}
