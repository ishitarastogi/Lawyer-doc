// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DocHashGenerator  {
    
    struct Document {
        address owner;
        uint timestamp;
    }
    
    address public creator;
    uint public numDocs;
    
    mapping(string => Document) public documentHashMap;
    mapping (address =>string ) message;

    constructor()  {
        creator = msg.sender;
        numDocs = 0;
    }
    
    function newDocument(string memory  hash) public  {
        require(!documentExists(hash),"Document already exist");
     
            Document storage doc = documentHashMap[hash];
            doc.owner = msg.sender;
            doc.timestamp = block.timestamp;
            numDocs++;

    }
    
    function documentExists(string memory hash) public view returns (bool exists) {
        if (documentHashMap[hash].timestamp > 0) {
            exists = true;
        } else {
            exists = false;
        }
        return exists;
    }
    
    function getDocument(string memory hash) public view returns (uint date, address owner) {
        date = documentHashMap[hash].timestamp;
        owner = documentHashMap[hash].owner;
    }

    function getNumDocs() public view returns (uint ) {
        return numDocs;
    }
  function transferOwnership(address _recipient, string memory hash) public{
       Document storage doc = documentHashMap[hash];
       message[_recipient] = hash;
        doc.owner = _recipient;

  }
    
}
