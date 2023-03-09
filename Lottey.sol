// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0<=0.9.0;

contract Lottery{
    address public manager;
    address payable[] public participate;
    
constructor()
{
    manager=msg.sender;
}
receive()external payable
{require(msg.value==2 ether);
participate.push(payable(msg.sender));
}
function getbalance() public view returns(uint)
{
require(msg.sender==manager);
return address(this).balance;

}
function random () public view returns(uint)
{
    return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participate.length)));
}
function selectwinner() public
{
    require(msg.sender==manager);
    require(participate.length>=3);
    uint r=random();
    
    address payable winner;
    uint index = r % participate.length;
    winner=participate[index];
    winner.transfer(getbalance());
    participate=new address payable[](0);
}


}