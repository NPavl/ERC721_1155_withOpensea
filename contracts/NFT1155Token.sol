// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

// после минта Nтокенов этот контракт не видит opensea https://testnets.opensea.io/get-listed/step-two,  
// так как этот контракт не соответствует полностью ERC1155, не реализует все его методы. 
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IERC1155.sol";

contract NFT1155Token is
    IERC1155, 
    Ownable
{
    using SafeMath for uint256;

    mapping(uint256 => mapping(address => uint256)) internal balances;

    mapping(address => mapping(address => mapping(uint256 => uint256)))
        internal allowances;

    mapping(address => mapping(address => bool)) internal operatorApproval;

    mapping(uint256 => address) public creators;

    mapping(uint256 => string) public mapUri;

    mapping(string => uint256) public mapStringOfURI;

    uint256 public nonce;

    modifier creatorOnly(uint256 _id) {
        require(creators[_id] == msg.sender);
        _;
    }

    function mint(
        uint256 _initialSupply,
        string calldata _uri 
    ) external override onlyOwner returns (uint256 _id) {
        _id = ++nonce;
        creators[_id] = msg.sender;
        balances[_id][msg.sender] = _initialSupply;
        mapUri[_id] = _uri;
        mapStringOfURI[_uri] = _id;

        emit URI(_uri, _id);
        emit TransferSingle(
            msg.sender,
            address(0x0),
            msg.sender,
            _id,
            _initialSupply
        );
    }

    function mintBatch(
        uint256 _id,
        address[] calldata _to, 
        uint256[] calldata _amounts 
    ) external override creatorOnly(_id) {
        for (uint256 i = 0; i < _to.length; ++i) {
            address to = _to[i];
            uint256 amounts = _amounts[i];

            balances[_id][to] = amounts.add(balances[_id][to]);

            emit TransferSingle(msg.sender, address(0x0), to, _id, amounts);
        }
    }

    function transerFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _value
    ) public override {
        require(_to != address(0x0), "_to must be not zero");
        require(
            _from == msg.sender ||
                operatorApproval[_from][msg.sender] == true ||
                checkAllowance(_from, _to, _id) >= _value,
            "Need approval"
        );
        balances[_id][_from] = balances[_id][_from].sub(_value);
        balances[_id][_to] = balances[_id][_to].add(_value);

        if (checkAllowance(_from, _to, _id) >= _value) {
            allowances[_from][msg.sender][_id] = allowances[_from][msg.sender][
                _id
            ].sub(_value);
        }

        emit TransferSingle(msg.sender, _from, _to, _id, _value);
    }

    function batchTransferFrom(
        address _from,
        address _to,
        uint256[] calldata _ids, 
        uint256[] calldata _values 
    ) external override {
        require(_to != address(0x0), "_to must be not zero");
        require(
            _ids.length == _values.length,
            "_ids and _values array lenght must match"
        );

        if (
            _from == msg.sender || operatorApproval[_from][msg.sender] == true
        ) {
            for (uint256 i = 0; i < _ids.length; ++i) {
                uint256 id = _ids[i];
                uint256 value = _values[i];
                balances[id][_from] = balances[id][_from].sub(value);
                balances[id][_to] = balances[id][_to].add(value);
            }
        } else {
            for (uint256 i = 0; i < _ids.length; ++i) {
                uint256 id = _ids[i];
                uint256 value = _values[i];
                require(
                    checkAllowance(_from, _to, id) >= value,
                    "Need approval for this transfer"
                );
                balances[id][_from] = balances[id][_from].sub(value);
                balances[id][_to] = balances[id][_to].add(value);
                allowances[_from][msg.sender][id] = allowances[_from][
                    msg.sender
                ][id].sub(value);
            }
        }
    }

    function balanceOf(
        address _owner,
        uint256 _id
    ) external view override returns (uint256) {
        return balances[_id][_owner];
    }

    function balanceOfBatch(
        address[] memory _owners,
        uint256[] memory _ids 
    ) external view override returns (uint256[] memory) {
        require(_owners.length == _ids.length);
        uint256[] memory balances_ = new uint256[](_owners.length);
        for (uint256 i = 0; i < _owners.length; ++i) {
            balances_[i] = balances[_ids[i]][_owners[i]];
        }
        return balances_;
    }

    function approve(
        address _spender,
        uint256 _id,
        uint256 _currentValue, 
        uint256 _value 
    ) external override {
        require(allowances[msg.sender][_spender][_id] == _currentValue);

        allowances[msg.sender][_spender][_id] = _value;

        emit Approval(msg.sender, _spender, _id, _currentValue, _value);
    }

    function checkAllowance(
        address _owner,
        address _spender,
        uint256 _id
    ) public override view returns (uint256) {
        return allowances[_owner][_spender][_id];
    }

function setApprovalForAll(address _operator,bool _approved) external override {
    operatorApproval[msg.sender][_operator] = _approved;
     
    emit ApprovalForAll(msg.sender, _operator, _approved); 
}

function  isApprovedForAll(address _owner, address _operator) external override view returns(bool) {
    return operatorApproval[_owner][_operator];
}

    function burn(
        address _from,
        uint256 _id,
        uint256 _amount
    ) external override {
        require(_from != address(0), "ERC1155: burn from the zero address");
        require(_from == msg.sender, "your not the owner");
        uint256 fromBalance = balances[_id][_from];
        require(fromBalance >= _amount, "ERC1155: burn amount exceeds balance");
        unchecked {
            balances[_id][_from] = fromBalance.sub(_amount);
        }

        emit BurnThisNFTShitSingle(_from, _id, _amount);
    }

    function burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts
    ) external override onlyOwner {
        require(from != address(0), "ERC1155: burn from the zero address");
        require(
            ids.length == amounts.length,
            "ERC1155: ids and amounts length mismatch"
        );
        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = balances[id][from];
            require(
                fromBalance >= amount,
                "ERC1155: burn amount exceeds balance"
            );
            balances[id][from] = fromBalance.sub(amount);
        }

        emit BurnThisNFTShitBatch(from, ids, amounts);
    }
}
