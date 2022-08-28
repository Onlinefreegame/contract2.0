//SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
contract Blocktrain{
    address public owner;

    struct locker{
        uint256 value;
        uint256 time_locked;
    }
    uint counter=0;
    mapping(uint=>locker) Vault;

    //modifier
    modifier onlyowner(){
        require(msg.sender==owner,"Not your vault");
        _;
    }
    constructor(){
        owner=msg.sender;
    }
    //deposit
    function depositInVault( uint256 _time) public payable {
        counter+=1;
        Vault[counter].value=msg.value;
        Vault[counter].time_locked=_time;
        counter+=1;
    }
    //withdraw
    function withdrawFromVault(uint _num) public payable onlyowner{
        require(block.timestamp>=Vault[_num].time_locked, "Come back later");
        payable(owner).transfer(Vault[_num].value);
        
    }
}
