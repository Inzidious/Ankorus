pragma solidity ^0.4.11;

interface IERC20
{
    function total_supply() constant returns( uint256 total );
    function get_balance() constant returns( uint256 balance );
    
    function transfer( address _dest, uint256 amount ) returns( bool success );
    function transfer_from( address _source, address _dest ) returns( bool success );
    
    function approve( address _spender, uint256 _value ) returns( bool success );
    function allowence( address _owner, address _spender ) returns ( uint256 remaining );
}