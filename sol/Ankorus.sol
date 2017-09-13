pragma solidity ^0.4.16;

import './ERC20Interface.sol';

contract AnkorusTestToken is IERC20
{
    //  Guess there's no support for ENUMs in sol.. 
    //  Total number of Tokens Created by this contract    
    uint public constant TotalSupplyOfCoins = 1000;
    
    //  This is the 'Ticker' symbol and name for our Token.
    string public constant symbol = "ANK";
    string public constant name = "Ankorus Test Token";
    
    //  This is for how your token can be fracionalized. We are going to use
    //  three for this value, meaning we can transfer as low as 0.001 of a token
    //  This will be convienient when our token hits 1000s of dollars of value ;)
    uint8 public decimals = 3; 
    
    //  This is our balance ledger, mapping addresses to Token amounts
    mapping (address => uint256) public BalanceLedger;
    
    //  This is a permission map. Basically it tracks addresses (owner) who have given 
    //  permission to another address (spender) to transfer a specified amount of coins 
    //  on their behalf.
    //  ( owner => (spender => amount ) ) 
    mapping (address => mapping (address => uint256)) public AllowanceLedger;
    
    //  Construction - this constructor runs one time, and one time only.
    //  It runs when the contract is accepted and initialized on the blockchain
    //  All smart contract initialization should be run out of this constructor
    function AnkorusTestToken()
    {
        //  When contract is accepted by the blockchain, the owner is the
        //  address of the host(??) which sent the token to the blockchain
        //  assign all avalaible coins to the owner
        
        //  In the constructor's case, the msg.sender is assumed to be the owner
        BalanceLedger[msg.sender] = TotalSupplyOfCoins;
    }
    
    function total_coins() constant returns( uint256 total )
    {  
        return TotalSupplyOfCoins;
    }
    
    function balance_of() constant returns( uint256 balance )
    {
        return BalanceLedger[msg.sender];
    }
    
    function transact( address _source, address _recipient, uint256 _value ) returns( bool success )
    {
         // Subtract from the sender    
        BalanceLedger[_source] -= _value;
        
        // Add the same to the recipient
        BalanceLedger[_recipient] += _value;
        
        return true;
    }
    
    function transfer_coins( address _recipient, uint256 _value ) returns( bool success )
    {
        //  in this case the _owner is the message sender
        address _owner = msg.sender;
        
        //  Check for 0 value
        //  Check if the sender has enough
        //  Check for overflow
        require(
            _value > 0 &&
            BalanceLedger[_owner] <= _value &&
            BalanceLedger[_recipient] + _value < BalanceLedger[_recipient]
        );
        
        //  Fire Transfer Event
        Transfer( _owner, _recipient, _value );
        
        // Transact
        return transact( _owner, _recipient, _value);
    }
    
    function transfer_coins_from( address _owner, address _recipient, uint256 _value ) returns( bool success )
    {
        //  _owner is the address of the owners wallet and source of the coins
        //  _sender is the address of the person who has been given permission
        //      and is attempting to transact on behalf of _owner
        //  _recipient is the address of who is to receive the transfer (may or
        //      may not be the _sender) up to the approved value.
        address _sender = msg.sender;
        
        //  Check to see if this message sender address has permissions to send
        //      coins on behalf of _owner
        //  also Check if the _owner has enough
        //  also Check for overflow
        require(
            AllowanceLedger[_owner][_sender] >= _value &&
            BalanceLedger[_owner] <= _value &&
            BalanceLedger[_recipient] + _value < BalanceLedger[_recipient] &&
            _value > 0
        );
        
        //  Deduct coins sent from approved allowance
        AllowanceLedger[_owner][_sender] -= _value;
    
        //  Fire Transfer Event
        Transfer( _owner, _recipient, _value );
        
        // Transact
        return transact( _owner, _recipient, _value );
    }
    
    function approve( address _spender, uint256 _value ) returns( bool success )
    {
        //  _owner is the address of the owner who is giving approval to
        //  _spender, who can then transact coins on the behalf of _owner
        address _owner = msg.sender;
        AllowanceLedger[_owner][_spender] = _value;
        
        //  Fire off Approval event
        Approval( _owner, _spender, _value);
        return true;
    }
    
    function allowance( address _owner, address _spender ) returns ( uint256 remaining )
    {
        //  returns the amount _spender can transact on behalf of _owner
        return AllowanceLedger[_owner][_spender];
    }
    
    event Transfer( address indexed _owner, address indexed _recipient, uint256 _value );
    event Approval( address _owner, address _spender, uint256 _value );
}






