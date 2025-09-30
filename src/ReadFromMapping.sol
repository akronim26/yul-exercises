// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromMapping {
    mapping(uint256 => uint256) readMe;

    function setValue(uint256 index, uint256 value) external {
        readMe[index] = value;
    }

    function main(uint256 index) external view returns (uint256) {
        bytes32 slot = keccak256(abi.encode(index, 0));
        assembly {
            // read the value at the `index` in the mapping `readMe`
            // and return it
            let value := sload(slot)
            mstore(0x00, value)
            return(0x00, 0x20)
        }
    }
}
