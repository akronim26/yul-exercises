// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PaymentSplitter {
    function main(address[] calldata recipients) external payable {
        assembly {
            let arrOffset := calldataload(0x04)        
            let len := calldataload(add(0x04, arrOffset)) 
            let amount := div(selfbalance(), len)
            let dataStart := add(add(0x04, arrOffset), 0x20)
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let recipient := calldataload(add(dataStart, mul(i, 0x20)))
                let success := call(gas(), recipient, amount, 0, 0, 0, 0)
                if iszero(success) {
                    revert(0, 0)
                }
            }
        }
    }
}
