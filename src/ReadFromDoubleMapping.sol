// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDoubleMapping {
    mapping(address => mapping(address => uint256)) public balances;

    function setValue(address user, address token, uint256 value) external {
        balances[user][token] = value;
    }

    function main(address user, address token) external view returns (uint256) {
        bytes32 innerSlot = keccak256(abi.encode(user, 0));
        bytes32 slot = keccak256(abi.encode(token, innerSlot));
        assembly {
            let val := sload(slot)
            mstore(0x00, val)
            return(0x00, 0x20)
            // your code here
            // read and return the `token` balance of `user` in the double mapping `balances`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
