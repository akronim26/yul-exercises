// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalculatorInFallback {
    uint256 public result;

    fallback() external {
        // your code here
        // compare the function selector in the calldata with the any of the selectors below, then
        // execute a logic based on the right function selector and store the result in `result` variable.
        // assumming operations won't overflow

        // add(uint256,uint256) -> 0x771602f7 (add two numbers and store result in storage)
        // sub(uint256,uint256) -> 0xb67d77c5 (sub two numbers and store result in storage)
        // mul(uint256,uint256) -> 0xc8a4ac9c (mul two numbers and store result in storage)
        // div(uint256,uint256) -> 0xa391c15b (div two numbers and store result in storage)
        assembly {
            let word := calldataload(0)
            let selector := shr(224, word)
            let a := calldataload(4)
            let b := calldataload(36)
            let _result
            if eq(selector, 0x771602f7) {
                _result := add(a, b)
            }
            if eq(selector, 0xb67d77c5) {
                _result := sub(a, b)
            }
            if eq(selector, 0xc8a4ac9c) {
                _result := mul(a, b)
            }
            if eq(selector, 0xa391c15b) {
                _result := div(a, b)
            }
            sstore(result.slot, _result)
        }
    }
}
