// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Voter {
  struct Candidate {
    uint id;
    string name;
    uint totalVotes;
  }

  mapping(address => bool)  private voters;
  mapping(uint => Candidate) public candidates;
  uint private Count;

  event voteEvent (
    uint indexed candidateID
  );
  
  function addCandidate (string  memory new_name) public {
    Count ++;
    candidates[Count] = Candidate(Count, new_name, 0);
  }

  function vote (uint candidateID) public {
    require(!voters[msg.sender]);
    require(candidateID  > 0 && candidateID <= Count);
    voters[msg.sender] = true;
    candidates[candidateID].totalVotes ++;
    emit voteEvent(candidateID);
  }
}
