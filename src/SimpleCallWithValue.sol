// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCallWithValue {

    function main(address t) external payable {
        assembly {
            // your code here
            // call "t.foo()" while sending msg.value
            // hint: "foo()" has function selector 0xc2985578
            // hint: callvalue() returns the value of the current call
            let ptr := mload(0x40)
            mstore(ptr, 0xc298557800000000000000000000000000000000000000000000000000000000)
            let _gas := gas()
            let success := call(_gas, t, callvalue(), ptr, 4, 0, 0)
       }
    }
}