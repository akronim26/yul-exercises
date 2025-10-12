// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SquareRoot {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            switch x
            case 0 {
                mstore(0x00, 0)
                return(0x00, 0x20)
            }
            case 1 {
                mstore(0x00, 1)
                return(0x00, 0x20)
            }
            default {
                let z := add(div(x, 2), 1)
                let y
                for {

                } 1 {

                } {
                    y := div(add(z, div(x, z)), 2)
                    if iszero(lt(y, z)) {
                        break
                    }
                    z := y
                }

                mstore(0x00, z)
                return(0x00, 0x20)
            }
        }
    }
}
