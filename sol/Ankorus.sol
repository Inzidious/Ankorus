pragma solidity ^0.4.2;

import './ERC20Interface.sol';

contract AnkorusTestToken is IERC20
{
    /* Public variables of the token */
    string public standard = 'Token 0.1';
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    
    function total_supply() constant returns( uint256 total )
    {  
        return totalSupply;
    }
    
    function get_balance() constant returns( uint256 balance )
    {
        return balanceOf[msg.sender];
    }
    
    function transfer(  address _source, address _dest, uint256 _value ) returns( bool success )
    {
         // Subtract from the sender    
        balanceOf[_source] -= _value;
        
        // Add the same to the recipient
        balanceOf[_dest] += _value;
        
        return true;
    }
    
    function transfer_from( address _source, address _dest, uint256 _value ) returns( bool success )
    {
        _source = msg.sender;
        
        // Check if the sender has enough
        if(balanceOf[_source] < _value ) 
            return false;
            
        // Check for overflows
        if( balanceOf[_dest] + _value < balanceOf[_dest]) 
            return false;
            
        // Transact
        return transfer(_source, _dest, _value);
    }
    
    function approve( address _spender, uint256 _value ) returns( bool success );
    function allowence( address _owner, address _spender ) returns ( uint256 remaining );
    
    event Transfer( address indexed _from, address indexed _to, uint256 _value );
    event Approval( );
    
    
}