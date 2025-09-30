// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            // pop the last element from the dynamic array `popFromMe`
            // don't forget to clean the popped element's slot.
            // 1. The slot of popFromMe is 0
            let arrSlot := 0
            // 2. Load the current length
            let len := sload(arrSlot)
            // 3. Revert if array is empty
            if iszero(len) { revert(0, 0) }
            // 4. Compute the storage slot of the first element: keccak256(0, 32)
            mstore(0x0, arrSlot)
            let dataSlot := keccak256(0x0, 0x20)
            // 5. Compute the slot of the last element: dataSlot + (len - 1)
            let lastElemSlot := add(dataSlot, sub(len, 1))
            // 6. Zero out the last element's slot
            sstore(lastElemSlot, 0)
            // 7. Decrement the array length
            sstore(arrSlot, sub(len, 1))
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
