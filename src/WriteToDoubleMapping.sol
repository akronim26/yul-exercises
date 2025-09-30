// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDoubleMapping {
    mapping(address  => mapping(address  => uint256)) public balances;

    function main(address user, address token, uint256 value) external {
        bytes32 innerSlot = keccak256(abi.encode(user, 0));
        bytes32 slot = keccak256(abi.encode(token, innerSlot));
        assembly {
            // your code here
            sstore(slot, value)
            // set the `value` for a `user` and a `token`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
