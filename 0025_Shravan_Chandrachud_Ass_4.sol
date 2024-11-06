// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {
    
    // Define a structure for student data
    struct Student {
        uint id;
        string name;
        uint grade;
    }
    
    // Array to store multiple students
    Student[] public students;

    // Mapping to check if a student ID already exists
    mapping(uint => bool) private studentExists;
    
    // Event to log addition of a new student
    event StudentAdded(uint id, string name, uint grade);
    
    // Receive function to reject direct Ether transfers
    receive() external payable {
        revert("This contract does not accept Ether");
    }

    // Fallback function to reject any unexpected Ether sent to the contract
    fallback() external payable {
        revert("This contract does not accept Ether");
    }
    
    // Function to add a new student
    function addStudent(uint _id, string memory _name, uint _grade) public {
        require(!studentExists[_id], "Student with this ID already exists");
        
        students.push(Student(_id, _name, _grade));
        studentExists[_id] = true;
        
        emit StudentAdded(_id, _name, _grade);
    }
    
    // Function to get the total number of students
    function getStudentCount() public view returns (uint) {
        return students.length;
    }

    // Function to retrieve a student's information by their index in the array
    function getStudent(uint index) public view returns (uint, string memory, uint) {
        require(index < students.length, "Student index is out of bounds");
        
        Student memory student = students[index];
        return (student.id, student.name, student.grade);
    }
}
