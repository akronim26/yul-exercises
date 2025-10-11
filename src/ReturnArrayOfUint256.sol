// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnArrayOfUint256 {
    function main(uint256 a, uint256 b, uint256 c) external pure returns (uint256[] memory) {
        assembly {
            // your code here
            // return an array of [a,b,c]
            let ptr := mload(0x40)
            mstore(ptr, 3)
            mstore(add(ptr, 0x20), a)
            mstore(add(ptr, 0x40), b)
            mstore(add(ptr, 0x60), c)
            mstore(0x40, add(ptr, 0x80))
            return(ptr, 0x80)
        }
    }
}
