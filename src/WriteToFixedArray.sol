// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToFixedArray {
    uint256[5] writeHere;

    function main(uint256[5] memory x) external {
        assembly {
            // your code here
            // store the values in the fixed array `x` in the storage variable `writeHere`
            // We need to store each element of x into the corresponding storage slot of writeHere.
            // The storage slot of writeHere is given by `writeHere.slot`
            // Each element is stored at writeHere.slot + i
            // x is a memory array, so we load each element from memory and store it in storage
            let base := writeHere.slot
            // The offset to the start of the x array in memory is passed as the argument
            // The first element of x is at x (pointer to start of array)
            for { let i := 0 } lt(i, 5) { i := add(i, 1) } {
                // mload(x) loads the first element, mload(add(x, 0x20)) the second, etc.
                let value := mload(add(x, mul(i, 0x20)))
                sstore(add(base, i), value)
            }
        }
    }

    function getter() external view returns (uint256[5] memory) {
        return writeHere;
    }
}
