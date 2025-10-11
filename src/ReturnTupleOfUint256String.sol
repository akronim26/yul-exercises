// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfUint256String {
    function main() external pure returns (uint256, string memory) {
        assembly {
            // your code here
            // return the tuple of (uint256 and string): (420, "RareSkills")
            let ptr := mload(0x40)
            mstore(add(ptr, 0x20), 0x60)
            mstore(ptr, 420)
            mstore(add(ptr, 0x40), 10)
            mstore(add(ptr, 0x60), 0x52617265536B696C6C73)
            mstore(0x40, add(ptr, 0x80))
            return(ptr, 0x80)
        }
    }
}
