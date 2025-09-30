// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PushToDynamicArray {
    uint256[] pushToMe = [23, 4, 19, 3, 44, 88];

    function main(uint256 newValue) external {
        assembly {
            // The storage slot of pushToMe is 0
            // The length is stored at slot 0
            // The data starts at keccak256(0)
            // 1. Load the current length
            let arrSlot := 0
            let len := sload(arrSlot)
            // 2. Compute the storage slot for the new element
            //    keccak256(0) + len
            mstore(0x0, arrSlot)
            let dataSlot := keccak256(0x0, 0x20)
            let newElemSlot := add(dataSlot, len)
            // 3. Store the new value at the new element slot
            sstore(newElemSlot, newValue)
            // 4. Increment the length
            sstore(arrSlot, add(len, 1))
        }
    }

    function getter() external view returns (uint256[] memory) {
        return pushToMe;
    }
}
