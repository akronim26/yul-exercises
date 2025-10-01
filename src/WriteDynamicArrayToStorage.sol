// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`
            let len := calldataload(x.offset)
            sstore(writeHere.slot, len) // store the length of the array
            let dataOffset := add(x.offset, 0x20) // offset to the first element
            let storageOffset := keccak256(writeHere.slot, 0x20) // offset to the first element in storage
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {  
                let element := calldataload(add(dataOffset, mul(i, 0x20)))
                sstore(add(storageOffset, i), element)   
            }
        }
    }
}
