// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnString {
    function main() external pure returns (string memory) {
        assembly {
            // your code here
            // return the exact string: `Hello, RareSkills`
            let ptr := mload(0x40)
            mstore(ptr, 17)
            mstore(add(ptr, 0x20), 0x48656C6C6F2C2052617265536B696C6C73)
            mstore(0x40, add(ptr, 0x40))
            return(ptr, 0x40)
        }
    }
}
