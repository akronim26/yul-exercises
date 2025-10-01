// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromMappingInStruct {
    struct RandomValues {
        uint256 someValue1;
        uint128 someValue2;
        uint128 someValue3;
        mapping(uint256 index => uint256) readMe;
        uint256 someValue4;
    }

    uint256 someValue5 = 7;
    RandomValues randValues;

    function setValue(uint256 i, uint256 v, uint256 s1, uint128 s2, uint128 s3, uint256 s4, uint256 s5) external {
        randValues.someValue1 = s1;
        randValues.someValue2 = s2;
        randValues.someValue3 = s3;
        randValues.someValue4 = s4;
        randValues.readMe[i] = v;
        someValue5 = s5;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // To access randValues.readMe[index], we need to compute the storage slot:
            // keccak256(abi.encode(index, mappingSlot)), where mappingSlot = 3 (readMe's slot in struct) + struct's slot (0)
            mstore(0x00, index) // store index at 0x00
            mstore(0x20, 3)     // mapping slot for readMe in struct is 3, randValues is at slot 0
            let slot := keccak256(0x00, 0x40) // keccak256(index . mappingSlot)
            let val := sload(slot)
            mstore(0x00, val)
            return(0x00, 0x20)
        }
    }
}
