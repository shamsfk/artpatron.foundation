pragma solidity ^0.4.18;

import "./ArtPatronDataAccess.sol";
import "./Ownable.sol";

contract ArtPatronManagement is ArtPatronDataAccess, Ownable {
    function AddItem(
        string _name,
        uint _creationDate,
        uint _authorId,
        uint _holderId
    )
        external onlyManager
    {
        require(authors.length > _authorId);
        require(holders.length > _holderId);

        items.push(Item(
            _name,
            _authorId,
            _holderId,
            _creationDate,
            1 ether,
            0,
            0,
            0
        ));
    }

    function AddAuthor(string _name, uint _birthDate)
        external onlyManager
    {
        authors.push(Author(_name, _birthDate));
    }

    function AddHolder(string _name, uint16 _countryId)
        external onlyManager
    {
        holders.push(Holder(_name, _countryId));
    }

    function ChangeItemHolder(uint _itemId, uint _newHolderId)
        external onlyManager
    {
        items[_itemId].holderId = _newHolderId;
    }
}
