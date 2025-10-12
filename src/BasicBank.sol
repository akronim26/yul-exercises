// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BasicBank {
    // Events
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    error InsufficientBalance();

    mapping(address => uint256) public balances;

    function deposit() external payable {
        bytes32 depositSelector = Deposit.selector;
        assembly {
            mstore(0x00, callvalue())
            log2(0x00, 0x20, depositSelector, caller())
            mstore(0x00, caller())
            mstore(0x20, 0)  
            let slot := keccak256(0x00, 0x40)
            let bal := sload(slot)
            bal := add(bal, callvalue())
            sstore(slot, bal)
        }
    }

    function withdraw(uint256 amount) external returns (uint256 bal) {
        bytes32 withdrawSelector = Withdraw.selector;
        bytes4 insufficientBalanceSelector = InsufficientBalance.selector;

        assembly {
            mstore(0x00, caller())
            mstore(0x20, 0)
            let slot := keccak256(0x00, 0x40)
            bal := sload(slot)
            if lt(bal, amount) {
                mstore(0x00, insufficientBalanceSelector)
                revert(0x00, 0x04)  
            }
            bal := sub(bal, amount)
            sstore(slot, bal)
            mstore(0x00, amount)
            log2(0x00, 0x20, withdrawSelector, caller())
            let success := call(gas(), caller(), amount, 0, 0, 0, 0)
            if iszero(success) {
                revert(0, 0)
            }
        }
    }
}
