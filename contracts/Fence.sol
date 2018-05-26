pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Vault is Ownable{
  using SafeMath for uint256;
      
  mapping (uint256 => mapping (uint256 => address)) owners;
  
  event Bought(uint256 kLatitude,  uint256 kLongitude);
  event Transfered(uint256 kLatitude,  uint256 kLongitude, address from, address to);

  constructor() public {
    
  }

  function buy(uint256 kLatitude, uint256 kLongitude) public payable {
    require(owners[kLatitude][kLongitude] == 0);

    owners[kLatitude][kLongitude] = msg.sender;
    owner.transfer(msg.value);

    emit Bought(kLatitude, kLongitude);
  }

  function isOwnBy(uint256 kLatitude, uint256 kLongitude, address from) public constant returns (bool) {
    require(owners[kLatitude][kLongitude] == 0);

    return (owners[kLatitude][kLongitude] == from);
  }

  /**
  * @dev transfer token for a specified address
  * @param kLatitude latitude*1000.
  * @param kLongitude longitude*1000.
  * @param to The address to transfer to.
  */
  function transfer(uint256 kLatitude, uint256 kLongitude, address to) public returns (bool) {
    require(to != address(0));
    require(owners[kLatitude][kLongitude] == msg.sender);

    owners[kLatitude][kLongitude] = to;

    emit Transfered(kLatitude, kLongitude, msg.sender, to);
    return true;
  }

}
