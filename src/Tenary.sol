// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Tenary {
    uint256 public result;

    function main(uint256 a, uint256 b, uint256 c) external {
        assembly {
            // store `10` in the storage variable `result` if a > b,
            // else if b > c, store `20`,
            // else, store `30`
            let value
            switch gt(a, b)
            case 1 {
                value := 10
            }
            default {
                switch gt(b, c)
                case 1 {
                    value := 20
                }
                default {
                    value := 30
                }
            }
            sstore(result.slot, value)
        }
    }
}
