// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 10e18;

    function fundFundMe(address fundMe) public {
        vm.startBroadcast();
        FundMe(payable(fundMe)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
    }

    function run() external {
        address fundMe = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(fundMe);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address fundMe) public {
        vm.startBroadcast();
        FundMe(payable(fundMe)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address fundMe = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(fundMe);
        console.log("Withdrew from FundMe contract at %s", fundMe);
    }
}
