// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimpleCalldata {
    function main(
        bytes calldata deploymentBytecode
    ) external returns (address) {
        assembly {
            // your code here
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: use calldatacopy to copy the deploymentBytecode to memory
            let bytecodePointer := calldataload(0x04)
            calldatacopy(0x00, bytecodePointer, 0x20)
            let bytecodeLength := mload(0x00)
            let bytecodeMemoryOffset := 0x20
            calldatacopy(
                bytecodeMemoryOffset,
                add(bytecodePointer, 0x20),
                bytecodeLength
            )
            let addr := create(0, bytecodeMemoryOffset, bytecodeLength)
            mstore(0x00, addr)
            return(0x00, 0x20)
        }
    }
}
