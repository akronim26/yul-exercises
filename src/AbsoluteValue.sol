// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AbsoluteValue {
    function main(int256 x) external pure returns (uint256) {
        assembly {
            // your code here
            // return the absolute value of x
            // hint: use signed comparisons
            // hint: https://www.rareskills.io/post/signed-int-solidity
            let result
            if iszero(gt(x, 0)) {
                result := sub(0, x)
            }
            if iszero(lt(x, 0)) {
                result := x
            }
            mstore(0x00, result)
            return(0x00, 0x20)
        }
    }
}
