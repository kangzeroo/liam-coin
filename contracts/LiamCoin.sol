// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;


// import "./IER20.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// import "./extensions/IERC20Metadata.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol
interface IERC20Metadata {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

// import "../../utils/Context.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol
abstract contract Context {
    // override these virtual functions
    // we use these because sometimes the account sending and  paying for execution may not be the actual sender (as far as an application is concerned).
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// ERC20 Implementation
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping (address => uint256) public _balances;
    mapping (address => mapping (address => uint256)) public _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor (string memory name_, string memory symbol_, uint8 decimals_) public {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(_msgSender()) >= amount, "Insufficient balance");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        require(spender != address(0), "Spender cannot be the zero address");
        require(amount >= 0, "Amount must be greater than 0");
        _approve(_msgSender(), spender, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(sender) >= amount, "Insufficient balance");
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = allowance(sender, _msgSender());
        require(currentAllowance >= amount, "Insufficient allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;
    }
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        require(addedValue > 0, "Amount must be greater than 0");
        _approve(_msgSender(), spender, allowance(_msgSender(), spender) + addedValue);
        return true;
    }
    function decreaseAllowance(address spender, uint256 decreasedValue) public virtual returns (bool) {
        require(decreasedValue > 0, "Amount must be greater than 0");
        uint256 currentAllowance = allowance(_msgSender(), spender);
        require(currentAllowance >= decreasedValue, "Allowance cannot be negative");
        _approve(_msgSender(), spender, currentAllowance - decreasedValue);
        return true;
    }
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "Sender cannot be the zero address");
        require(recipient != address(0), "Recipient cannot be the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        uint256 senderBalance = balanceOf(sender);
        require(senderBalance >= amount, "Insufficient balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] = balanceOf(recipient) + amount;
        emit Transfer(sender, recipient, amount);
        _afterTokenTransfer(sender, recipient, amount);
    }
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "Sender cannot be the zero address");
        require(spender != address(0), "Spender cannot be the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    
    function _mint(address account, uint256 amount) internal {
        require(amount > 0, "Amount must be greater than 0");
        require(account != address(0), "Account cannot be the zero address");
        _beforeTokenTransfer(address(0), account, amount);
        _balances[account] = balanceOf(account) + amount;
        _totalSupply = _totalSupply + amount;
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount);
    }
    function _burn(address account, uint256 amount) internal virtual {
        require(balanceOf(_msgSender()) > 0, "Cannot burn more than you have");
        _beforeTokenTransfer(_msgSender(), address(0), balanceOf(_msgSender()));
        uint256 accountBalance = balanceOf(_msgSender());
        require(accountBalance >= amount, "Cannot burn more than you have");
        _balances[account] = accountBalance - amount;
        _totalSupply = _totalSupply - amount;
        emit Transfer(account, address(0), amount);
        _afterTokenTransfer(_msgSender(), address(0), amount);
    }
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {
    }
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {
    }
}

contract LiamCoin is ERC20 {
    constructor() ERC20("LiamCoin", "SLAM", 18) {
    }

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
}