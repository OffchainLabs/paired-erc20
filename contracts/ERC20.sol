// SPDX-License-Identifier: Apache-2.0

/*
 * Copyright 2019-2020, Offchain Labs, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pragma solidity ^0.7.0;

import "./interface/IGlobalInbox.sol";
import "./interface/IArbSys.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BaseDetails is ERC20 {
    constructor() ERC20("Token Buddy", "TB") {}
}

contract ArbERC20 is BaseDetails {
  function adminMint(address account, uint256 amount) public {
        // This function is only callable through admin logic since address 1 cannot make calls
        require(msg.sender == address(1));
        _mint(account, amount);
    }

    function withdraw(address account, uint256 amount) public {
        _burn(msg.sender, amount);
        IArbSys(100).withdrawERC20(account, amount);
    }
}

contract EthERC20 is Ownable, BaseDetails {
    address public inbox;

    constructor(address _globalInbox) {
        inbox = _globalInbox;
        _mint(msg.sender, 100 ether);
    }

    function connectToChain(address _chain) public onlyOwner {
        IGlobalInbox(inbox).deployL2ContractPair(
          _chain,
          10000000000, // max gas
          0, // gas price
          0, // payment
          type(ArbERC20).creationCode
        );
    }

    function mint(address account, uint256 amount) public {
        require(inbox == msg.sender, "only callable by global inbox");
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public {
        require(inbox == msg.sender, "only callable by global inbox");
        _burn(account, amount);
    }
}
