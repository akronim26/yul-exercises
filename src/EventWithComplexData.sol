// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithComplexData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, address[] players, uint256[] scores);

    function main(
        address emitter,
        address[] memory players,
        uint256[] memory scores
    ) external {
        bytes32 hash = keccak256("MyEvent(address,address[],uint256[])");
        assembly {
            // your code here
            // emit the `MyEvent(address,address[],uint256[])` event
            // Hint: Use `log2` to emit the event with the hash as the topic0 and `emitter` as topic1, then the data
            let ptr := mload(0x40)
            let playersLen := mload(players) // length of players array
            mstore(ptr, playersLen) // store length at ptr
            let offset := 0x20
            for {
                let i := 0
            } lt(i, playersLen) {
                i := add(i, 1)
            } {
                mstore(
                    add(ptr, offset),
                    mload(add(players, add(0x20, mul(i, 0x20))))
                )
                offset := add(offset, 0x20)
            }
            let scoresLen := mload(scores)
            mstore(add(ptr, offset), scoresLen)
            offset := add(offset, 0x20)
            for {
                let i := 0
            } lt(i, scoresLen) {
                i := add(i, 1)
            } {
                mstore(
                    add(ptr, offset),
                    mload(add(scores, add(0x20, mul(i, 0x20))))
                )
                offset := add(offset, 0x20)
            }
            log2(ptr, offset, hash, emitter)
            mstore(0x40, add(ptr, offset))
        }
    }
}
