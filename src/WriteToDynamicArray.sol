// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // Store the length of x into writeHere.slot
            sstore(writeHere.slot, mload(x))

            // Calculate the storage slot for writeHere[0]
            // keccak256(writeHere.slot)
            mstore(0x00, writeHere.slot)
            let base := keccak256(0x00, 0x20)

            // Get the length of x
            let len := mload(x)

            // The data of x starts at x + 0x20
            let data := add(x, 0x20)

            // Store each element
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                sstore(add(base, i), mload(add(data, mul(i, 0x20))))
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
