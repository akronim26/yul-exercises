// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfStringUnit256 {
    function main() external pure returns (string memory, uint256) {
        assembly {
            // your code here
            // return the tuple of (string and uint256): ("RareSkills", 420)
            let ptr := mload(0x40)
            mstore(ptr, 0x40)
            mstore(add(ptr, 0x20), 420)
            mstore(add(ptr, 0x40), 10)
            mstore(add(ptr, 0x60), 0x52617265536B696C6C73)
            mstore(0x40, add(ptr, 0x80))
            return(ptr, 0x80)
        }
    }
}
