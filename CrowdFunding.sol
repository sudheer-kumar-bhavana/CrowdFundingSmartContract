//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract CrowdFunding{

    address public CEO; 
    uint public endOn;
    uint public minBuy;
    uint public maxBuy;
    uint public targetAmount;

    mapping(address=>uint) participants;
    uint public participantsCount;
    uint public totalRaisedAmount;

    constructor(uint _targetAmount, uint _minBuy, uint _maxBuy, uint _endOn){
        require(_minBuy <= _maxBuy, "Bad inputs");
        targetAmount = _targetAmount;
        endOn =_endOn * 24 * 60 * 60 + block.timestamp;
        minBuy = _minBuy;
        maxBuy = _maxBuy;
        CEO=msg.sender;
    }
    
    function fund() public payable{
        require(block.timestamp < endOn, "Funding period ended");
        require(msg.value >=minBuy,  append("Minimum wei to fund is ",   Strings.toString(minBuy)));

        if(participants[msg.sender]==0){
            participantsCount++;
        }else{
            require(msg.value + participants[msg.sender] <= maxBuy, append("You can't fund more than ", Strings.toString(maxBuy)));
        }

        participants[msg.sender]+=msg.value;
        totalRaisedAmount+=msg.value;

    }

    function getAmountRaisedSofar() public view returns(uint){
        return address(this).balance;
    }

    function refund() public{
        require(block.timestamp > endOn && totalRaisedAmount < targetAmount, "This operation not allowed");
        require(participants[msg.sender] > 0);

        address payable participant =payable(msg.sender);
        participant.transfer(participants[msg.sender]);
        participants[msg.sender]=0;
    }

    function append(string memory s1, string memory s2) internal pure returns (string memory s3) {
        s3 = string(abi.encodePacked(s1, s2));
        return s3;
    }
    
}

