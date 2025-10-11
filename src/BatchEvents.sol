// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(
        address[] memory emitters,
        bytes32[] memory ids,
        uint256[] memory nums
    ) external {
        bytes32 hash =keccak256("MyEvent(address,bytes32,uint256)");
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.
            let len := mload(emitters) // number of events
            let i := 0
            for {

            } lt(i, len) {
                i := add(i, 1)
            } {
                let emitter := mload(add(emitters, add(0x20, mul(i, 0x20))))
                let id := mload(add(ids, add(0x20, mul(i, 0x20))))
                let num := mload(add(nums, add(0x20, mul(i, 0x20))))
                let ptr := mload(0x40)
                mstore(ptr, num)
                mstore(0x40, add(ptr, 0x20))
                log3(ptr, 0x20, hash, emitter, id)
            }
        }
    }
}
