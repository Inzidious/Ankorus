pragma solidity ^0.4.16;

interface IERC20
{
    function total_coins() constant returns( uint256 total );
    function balance_of() constant returns( uint256 balance );
    
    function transfer_coins( address _recipient, uint256 _value ) returns( bool success );
    function transfer_coins_from( address _owner, address _recipient, uint256 _value ) returns( bool success );
    
    function approve( address _spender, uint256 _value ) returns( bool success );
    function allowance( address _owner, address _spender ) returns ( uint256 remaining );
    
    event Transfer( address indexed _from, address indexed _to, uint256 _value );
    event Approval( address _owner, address _spender, uint256 _value );
}