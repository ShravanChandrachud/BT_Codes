// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract MedicalRecords { 
    struct Record {
        uint256 patientID; 
        string Name; 
        uint256 doctorID;
        uint256 DOR; // Date of Registration 
        uint256 Age;
        string BloodGrp; 
        uint256 Haemoglobin; 
        address owner;
    }

    mapping(uint256 => Record) public records; 
    uint256 public recordCount;

    event RecordAdded(uint256 indexed id, address owner);
    function addRecord( uint256 _patientID, 
    string memory _Name, 
    uint256 _doctorID, 
    uint256 _DOR, 
    uint256 _Age,
    string memory _BloodGrp, 
    uint256 _Haemoglobin
    ) public {
        uint256 id = recordCount++; records[id] = Record({
            patientID: _patientID, 
            Name: _Name, 
            doctorID: _doctorID, 
            DOR: _DOR,Age: _Age,
            BloodGrp: _BloodGrp,
            Haemoglobin: _Haemoglobin,
             owner: msg.sender});
        emit RecordAdded(id, msg.sender);
        }

    function getRecord(uint256 id) public view returns (Record memory) { 
        return records[id];
    }

    function deleteRecord(uint256 id) public { 
        Record storage record = records[id];
        require(msg.sender == record.owner, "Only the owner can delete this record");
        delete records[id];
    }
}