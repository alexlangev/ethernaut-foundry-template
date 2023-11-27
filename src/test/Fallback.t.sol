pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import { Test } from "forge-std/Test.sol";

import { Fallback } from 'src/levels/01-Fallback/Fallback.sol';
import { FallbackFactory } from "src/levels/01-Fallback/FallbackFactory.sol";
import { Ethernaut } from "src/core/Ethernaut.sol";

contract FallbackTest is Test {
    function testFallbackHack() public {
        ////////// Core Setup //////////
        Ethernaut ethernaut;
        address eoaAddress = makeAddr("user");
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        
        ////////// Level Setup //////////
        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);
        // Sets msg.sender for all subsequent calls until stopPrank is called.
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(fallbackFactory);
        Fallback ethernautFallback = Fallback(payable(levelAddress));

        ////////// Solve Level Here! //////////
        // Claim  the ownership of the contract
        // Reduce its balance to 0
        
        ////////// Submit Level //////////
        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}