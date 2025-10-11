// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract DeployNBytes {
    function main(uint256 size) external returns (address) {
        assembly {
            let initCodeSize := add(0x0c, size)
            
            mstore(0x00, 0x6001600c60003960016000f300)
            
            let addr := create(0, 0x00, initCodeSize)
            
            mstore(0x00, addr)
            return(0x00, 0x20)
        }
    }
}