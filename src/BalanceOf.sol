// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BalanceOf {
    function main(address token) external view returns (uint256) {
        assembly {
            // return the balance of this contract using ERC20 "token"
            // balanceOf has function selector 0x70a08231 and signature "balanceOf(address)"
            // use staticcall since this is a view function
            
            let ptr := mload(0x40)
            
            // Store function selector (4 bytes)
            mstore(ptr, 0x70a0823100000000000000000000000000000000000000000000000000000000)
            
            // Store address (this contract) at offset 0x04
            mstore(add(ptr, 0x04), address())
            
            // Call token contract with staticcall
            // staticcall(gas, address, input_offset, input_size, output_offset, output_size)
            let success := staticcall(gas(), token, ptr, 0x24, ptr, 0x20)
            
            // Revert if call failed
            if iszero(success) {
                revert(0, 0)
            }
            
            // Load the return value from memory and return it
            let balance_ := mload(ptr)
            mstore(0x40, add(ptr, 0x20))
            return(ptr, 0x20)
        }
    }
}