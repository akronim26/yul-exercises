// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract FizzBuzz {
    function main(uint256 num) external pure returns (string memory) {
        assembly {
            // your code here
            // if `num` is divisible by 3 return the word "fizz",
            // if divisible by 5 with the word "buzz",
            // if divisible by both 3 and 5 return the word "fizzbuzz",
            // else return an empty string "".

            // Assume `num` is greater than 0.
            let ptr := mload(0x40)
            if and(iszero(mod(num, 3)), iszero(mod(num, 5))) {
                mstore(ptr, 8)
                mstore(add(ptr, 0x20), 0x66697A7A62757A7A)
                mstore(0x40, add(ptr, 0x40))
                return(ptr, 0x40)
            }
            if iszero(mod(num, 3)) {
                mstore(ptr, 4)
                mstore(add(ptr, 0x20), 0x66697A7A)
                mstore(0x40, add(ptr, 0x40))
                return(ptr, 0x40)
            }
            if iszero(mod(num, 5)) {
                mstore(ptr, 4)
                mstore(add(ptr, 0x20), 0x62757A7A)
                mstore(0x40, add(ptr, 0x40))
                return(ptr, 0x40)
            }
            mstore(ptr, 0) 
            mstore(0x40, add(ptr, 0x20))
            return(ptr, 0x20)
        }
    }
}
