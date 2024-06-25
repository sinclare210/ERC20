// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract ERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    mapping (address => uint256) private _balanceOf;
    mapping (address => mapping(address => uint256)) private _allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function name() public view returns (string memory){
        return _name;
    }

    function symbol() public view returns (string memory){
        return _symbol;
    }
    
    function decimals() public view returns (uint8){
        return _decimals;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256){
        return _balanceOf[owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool){
        require(_balanceOf[msg.sender] >= _value, "Insufficient");
        _balanceOf[msg.sender] -= _value;
        _balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool){
        require(_allowance[_from][msg.sender] >= _value,"No allowed");
        _balanceOf[_from] -= _value;
        _balanceOf[_to] += _value;
        _allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);

        return true;

    } 

    function approve (address _spender, uint256 _value) public returns (bool){
        _allowance[msg.sender][_spender] = _value;
        _balanceOf[msg.sender] -= _value;

        emit Approval(msg.sender,_spender,_value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256){
        return _allowance[_owner][_spender];

    }

}