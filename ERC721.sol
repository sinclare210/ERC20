// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ERC721 {
    //     // The address of the contract creator
    // address internal creator;
    // The highest valid tokenId, for checking if a tokenId is valid
    uint256 internal maxId;
    // A mapping storing the balance of each address
    mapping(address => uint256) internal balances;
    // A mapping of burnt tokens, for checking if a tokenId is valid
    
    mapping(uint256 => bool) internal burned;
    // A mapping of token owners
    mapping(uint256 => address) internal owners;
    // A mapping of the "approved" address for each token
    mapping (uint256 => address) internal allowance;
    // A nested mapping for managing "operators"
    mapping (address => mapping (address => bool)) internal authorised;

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256){
        return balances[_owner];
    }

    function ownerOf(uint256 _tokenId) private  view returns (address){
        return owners[_tokenId];
    }

    function setApprovalForAll(address _operator, bool _approved) external{
        emit ApprovalForAll(msg.sender, _operator, _approved);
        authorised[msg.sender][_operator] = _approved;
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return authorised[_owner][_operator];
    }

    function getApproved(uint256 _tokenId) external view returns (address) {
    
    return allowance[_tokenId];
    }

    function approve(address _approved, uint256 _tokenId)  external{
        address owner = ownerOf(_tokenId);
        require(msg.sender == owner );
        emit Approval(owner, _approved, _tokenId);
            allowance[_tokenId] = _approved;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);
        require(owner == msg.sender, "Permission no granted");
        require(owner == _from);
        emit Transfer(_from, _to, _tokenId);
        owners[_tokenId] = _to;
        balances[_from]--;
        balances[_to]++;

    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public{
        transferFrom(_from, _to, _tokenId);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external {
    safeTransferFrom(_from,_to,_tokenId,"");
    }


   



}