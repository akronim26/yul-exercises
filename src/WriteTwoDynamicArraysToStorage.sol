// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`
             let len := calldataload(x.offset)
            sstore(writeHere1.slot, len) // store the length of the array
            let dataOffset := add(x.offset, 0x20) // offset to the first element
            let storageOffset := keccak256(writeHere1.slot, 0x20) // offset to the first element in storage
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {  
                let element := calldataload(add(dataOffset, mul(i, 0x20)))
                sstore(add(storageOffset, i), element)   
            }

             let len_ := calldataload(y.offset)
            sstore(writeHere2.slot, len_) // store the length of the array
            let dataOffset_ := add(y.offset, 0x20) // offset to the first element
            let storageOffset_ := keccak256(writeHere2.slot, 0x20) // offset to the first element in storage
            for { let i := 0 } lt(i, len_) { i := add(i, 1) } {
                let element := calldataload(add(dataOffset_, mul(i, 0x20)))
                sstore(add(storageOffset_, i), element)
            }
        }
    }
}
