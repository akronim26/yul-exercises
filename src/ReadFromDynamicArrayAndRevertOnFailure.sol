// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        assembly {
            // Load the length of the array (slot 0)
            let len := sload(readMe.slot)
            // Check if index is negative or >= len
            // index < 0 or index >= len
            // int256 is signed, so check sign bit
            if or(slt(index, 0), iszero(lt(index, len))) {
                // Panic(uint256) selector: 0x4e487b71, code 0x32
                mstore(0x00, 0x4e487b7100000000000000000000000000000000000000000000000000000000)
                mstore(0x04, 0x32)
                revert(0x00, 0x24)
            }
            // Compute storage slot for readMe[index]
            mstore(0x00, readMe.slot)
            let base := keccak256(0x00, 0x20)
            let val := sload(add(base, index))
            mstore(0x00, val)
            return(0x00, 0x20)
        }
    }
}
