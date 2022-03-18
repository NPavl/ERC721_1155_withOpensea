// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

// opensea не видит этот контракт. нужен импорт ERC1155 

interface IERC1155 {
    event TransferSingle(
        address indexed _operator,
        address indexed _from,
        address indexed _to,
        uint256 _id,
        uint256 _value
    );

    event TransferBatch(
        address indexed _operator,
        address indexed _from,
        address indexed _to,
        uint256[] _ids,
        uint256[] _values
    );

    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    event URI(string _value, uint256 indexed _id);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 indexed _id,
        uint256 _oldValue,
        uint256 _value
    );

    event BurnThisNFTShitSingle(
        address indexed _from,
        uint256 indexed _id,
        uint256 _value
    );

    event BurnThisNFTShitBatch(
        address _from,
        uint256[] _id,
        uint256[] _value
    );

    function mint(uint256 _initialSupply, string calldata _uri)
        external
        returns (uint256);

    function mintBatch(
        uint256 _id,
        address[] calldata _to,
        uint256[] calldata _amounts
    ) external;

    function transerFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _value
    ) external;

    function batchTransferFrom(
        address _from,
        address _to,
        uint256[] calldata _ids,
        uint256[] calldata _values
    ) external;

    function balanceOf(address _owner, uint256 _id)
        external
        view
        returns (uint256);

    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids)
        external
        view
        returns (uint256[] memory);

    function setApprovalForAll(address _operator, bool _approved) external;

    function isApprovedForAll(address _owner, address _operator)
        external
        view
        returns (bool);

    function checkAllowance(
        address _owner,
        address _spender,
        uint256 _id
    ) external view returns (uint256);

    function approve(
        address _spender,
        uint256 _id,
        uint256 _currentValue,
        uint256 _value
    ) external;

    function burn(
        address _from,
        uint256 _id,
        uint256 _amount
    ) external;

    function burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts
    ) external;
}
