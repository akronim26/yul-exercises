// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPackedDynamicArray64 {
    uint64[] public writeHere;

    function main(uint64 v1, uint64 v2, uint64 v3, uint64 v4, uint64 v5) external {
        assembly {
            // your code here
            // write the code to store v1, v2, v3, v4, and v5 in the `writeHere` array in sequential order.
            // Hint: `writeHere` is a dynamic array, so you will need to access its length and use `mstore` or `sstore`
            // appropriately to push new values into the array.
            let arraySlot := sload(writeHere.slot)
            let length := sload(arraySlot)
            let newLength := add(length, 5)
            sstore(arraySlot, newLength)
            let slot := keccak256(0x00, 0x20)
            sstore(slot, or(v1, shl(64, or(v2, shl(64, or(v3, shl(64, or(v4, shl(64, v5)))))))))
        }
    }
}
