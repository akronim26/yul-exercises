// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            let len := mload(arr)
            if eq(len, 0) {
                revert(0, 0)
            }

            let max := mload(add(arr, 0x20))

            for {
                let i := 1
            } lt(i, len) {
                i := add(i, 1)
            } {
                let el := mload(add(add(arr, 0x20), mul(i, 0x20)))
                if lt(max, el) {
                    max := el
                }
            }
            mstore(0x00, max)
            return(0x00, 0x20)
        }
    }
}
