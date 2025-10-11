// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTwoBools {
    function main(bool a, bool b) external pure returns (bool, bool) {
        assembly {
            // your code here
            // return the tuple (a,b)
            let ptr := mload(0x40)
            mstore(ptr, a)
            mstore(add(ptr, 0x20), b)
            mstore(0x40, add(ptr, 0x40))
            return(ptr, 0x40)
        }
    }
}
