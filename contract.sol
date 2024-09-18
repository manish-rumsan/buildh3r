
pragma solidity ^0.8.0;

contract BasicToken {
    string public name = "BasicToken";    
    string public symbol = "BASIC";      
    uint8 public decimals = 18;         
    uint256 public totalSupply;         

    mapping(address => uint256) public balanceOf;  
    address public owner;                        

   
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor(uint256 _initialSupply) {
        owner = msg.sender;  
        totalSupply = _initialSupply * (10 ** uint256(decimals)); 
        balanceOf[msg.sender] = totalSupply;  
            }

    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); 
        balanceOf[msg.sender] -= _value;     
        balanceOf[_to] += _value;            
        emit Transfer(msg.sender, _to, _value); 
        return true;
    }

    
    function mint(uint256 _value) public onlyOwner returns (bool success) {
        uint256 amount = _value * (10 ** uint256(decimals)); 
        totalSupply += amount;          
        balanceOf[owner] += amount;     
        emit Mint(owner, amount);       
        return true;
    }
}
