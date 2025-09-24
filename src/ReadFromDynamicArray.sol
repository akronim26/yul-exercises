// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArray {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        uint256 slot = uint256(keccak256(abi.encode(0))) + index;
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            let value := sload(slot)
            mstore(0x00, value)
            return(0x00, 0x20)
            // Assume `index` is <= to the length of readMe
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
