pragma solidity ^0.4.21;

import "./ArtPatronData.sol";
import "../../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";

contract ArtPatronManagement is ArtPatronData, Ownable {
    address public collectorAddress; // address that collects fees and museum rewards

    event ItemAdded(uint itemId);
    event AuthorAdded(uint authorId);
    event HolderAdded(uint holderId);
    event ItemHolderChanged(uint itemId);

    function SetCollectorAddress(address ca) public onlyOwner {
        collectorAddress = ca;
    }

    function AddItem(
        string _name,
        uint _creationDate,
        uint _marketDate,
        uint _authorId,
        uint _holderId
    )
        public onlyOwner
    {
        require(authors.length > _authorId);
        require(holders.length > _holderId);

        require(bytes(_name).length > 0);

        items.push(Item(
            _name,
            items.length,
            _authorId,
            _holderId,
            _creationDate,
            1 ether,
            _marketDate,
            0
        ));

        emit ItemAdded(items.length - 1);
    }

    function AddAuthor(string _name, uint _birthDate)
        public onlyOwner
    {
        require(bytes(_name).length > 0);
        authors.push(Author(_name, authors.length, _birthDate));

        emit AuthorAdded(authors.length - 1);
    }

    function AddHolder(string _name, uint16 _countryId)
        public onlyOwner
    {
        require(bytes(_name).length > 0);
        holders.push(Holder(_name, holders.length, _countryId));

        emit HolderAdded(holders.length - 1);
    }

    function ChangeItemHolder(uint _itemId, uint _newHolderId)
        external onlyOwner
    {
        items[_itemId].holderId = _newHolderId;

        emit ItemHolderChanged(_itemId);
    }
}
