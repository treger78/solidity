pragma solidity ^0.7.4;

contract SimpleVoting {
    
    address hostVoting;
    
    constructor() {
        hostVoting = msg.sender;
    }
    
    uint deputyAmount;
    
    mapping(uint => uint) votingMembers;
    
    function setDeputyAmount(uint _deputyAmount) public returns (uint) {
        require(msg.sender == hostVoting);
        deputyAmount = _deputyAmount;
        for (uint i = 1; i < deputyAmount; i++) {
            votingMembers[i] = 0;
        }        
    }
    
    function getDeputyAmount() public view returns (uint) {
        return deputyAmount;
    }
    
    mapping(address => bool) votedPerson;
    
    function giveVote(uint _vote) public {
        require(_vote > 0 && _vote <= deputyAmount && votedPerson[msg.sender] != true);
        /*
        require(_vote > 0);
        require(_vote <= deputyAmount);
        require(votedPerson[msg.sender] != true);
        */
        votingMembers[_vote]++;
        votedPerson[msg.sender] = true;
    }
    
    function getWinner() public view returns (uint) {
        uint m = 0;
        for (uint i = 1; i < deputyAmount; i++) {
            if (votingMembers[i] > m) {
                m = i;
            }
        }
        return m;
    }
    
}
