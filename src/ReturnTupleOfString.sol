// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            // your code here
            // return the tuple of string: ("Hello", "RareSkills")
            let ptr := mload(0x40)
            mstore(ptr, 0x40)
            mstore(add(0x20, ptr), 0x80)
            mstore(add(ptr, 0x40), 5)
            mstore(add(ptr, 0x60), 0x48656C6C6F)
            mstore(0x40, add(ptr, 0x80))
            let new_ptr := mload(0x40)
            mstore(new_ptr, 10)
            mstore(add(new_ptr, 0x20), 0x52617265536B696C6C73)
            mstore(0x40, add(new_ptr, 0x40))
            return(ptr, 0xc0)
        }
    }
}
