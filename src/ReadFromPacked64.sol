// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromPacked64 {
    uint64 someValue1;
    uint64 someValue2;
    uint64 readMe;
    uint64 someValue3;

    function setValue(uint64 v1, uint64 v2, uint64 v3, uint64 v4) external {
        someValue1 = v1;
        someValue2 = v2;
        readMe = v3;
        someValue3 = v4;
    }

    function main() external view returns (uint256) {
        assembly {
            // your code here
            // unpack and read data from the storage variable `readMe` of type uint64
            // then return it
            let slot := sload(readMe.slot)
            let val := shr(128, slot)
            val := and(val, 0xFFFFFFFFFFFFFFFF)
            mstore(0x00, val)
            return(0x00, 32) // return the value read from readMe
        }
    }
}
