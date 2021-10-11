// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <0.9.0;

contract Insurance {
  address payable public hospital;
  address payable public insurer;
  struct Record {
    address Addr;
    uint256 ID;
    string Name;
    string date;
    uint256 price;
    bool isValue;
    uint256 signatureCount;
    mapping (address => uint256) signatures;
  }
  modifier signOnly {
    require (msg.sender == hospital || msg.sender == insurer);
    _;
  }
  
  constructor() public {
    hospital = payable(0xF67413b1a5643015dc394Dc86b1733A72Afa007D);
    insurer = payable(0x802776D387a725A474993c835017B9cCb7C66Edd);
  }
  mapping (uint256=> Record) public all_records;
  uint256[] public recordsArr;

  event recordCreated(uint256 ID, string testName, string date, uint256 price);
  event recordSigned(uint256 ID,  string testName, string date, uint256 price);

  function newRecord (uint256 _ID, string memory _Name, string memory _date, uint256 price) public {
    Record storage newrecord = all_records[_ID];
    require(!all_records[_ID].isValue);
    newrecord.Addr = msg.sender;
    newrecord.ID = _ID;
    newrecord.Name = _Name;
    newrecord.date = _date;
    newrecord.price = price;
    newrecord.isValue = true;
    newrecord.signatureCount = 0;
    recordsArr.push(_ID);
    emit recordCreated(newrecord.ID, _Name, _date, price);
  }
  function signRecord(uint256 _ID) signOnly public payable {
    Record storage records = all_records[_ID];
    require(records.signatures[msg.sender] != 1);
    records.signatures[msg.sender] = 1;
    records.signatureCount++;
    emit recordSigned(records.ID, records.Name, records.date, records.price);
    if(records.signatureCount == 2) {
      hospital.transfer(address(this).balance);
    }
  }
  
}
