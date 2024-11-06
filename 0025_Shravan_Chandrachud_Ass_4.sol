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
        require(studentExists[index], "Student index is out of bounds or doesn't exists");
        
        Student memory student = students[index];
        return (student.id, student.name, student.grade);
    }

    function showStudentList() public view returns (uint[] memory, string[] memory, uint[] memory) {
        uint length = students.length;
    
    // Initialize arrays to hold each field's data
        uint[] memory ids = new uint[](length);
        string[] memory names = new string[](length);
        uint[] memory grades = new uint[](length);

        for (uint i = 0; i < length; i++) {
            Student memory student = students[i];
            ids[i] = student.id;
            names[i] = student.name;
            grades[i] = student.grade;
        }
    
        return (ids, names, grades);
    }
}
