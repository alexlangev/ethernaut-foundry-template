// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Level } from 'src/core/BaseLevel.sol';
import { Fallback } from 'src/levels/01-Fallback/Fallback.sol';

contract FallbackFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    Fallback instance = new Fallback();
    return address(instance);
  }

  function validateInstance(address payable _instance, address _player) override public view returns (bool) {
    Fallback instance = Fallback(_instance);
    return instance.owner() == _player && address(instance).balance == 0;
  }
}