pragma solidity ^0.8.0;
contract DIDRegistry {
    struct DID {
        address owner;
        string didDocument;
    }

    mapping(string => DID) private dids;

    event DIDRegistered(string did, address owner);
    event DIDUpdated(string did, address owner);

    function registerDID(string memory did, string memory didDocument) public {
        require(bytes(did).length > 0, "DID must not be empty");
        require(bytes(didDocument).length > 0, "DID document must not be empty");
        require(dids[did].owner == address(0), "DID already registered");

        dids[did] = DID(msg.sender, didDocument);
        emit DIDRegistered(did, msg.sender);
    }

    function updateDID(string memory did, string memory didDocument) public {
        require(bytes(did).length > 0, "DID must not be empty");
        require(bytes(didDocument).length > 0, "DID document must not be empty");
        require(dids[did].owner == msg.sender, "Only the owner can update the DID");

        dids[did].didDocument = didDocument;
        emit DIDUpdated(did, msg.sender);
    }

    function getDID(string memory did) public view returns (address, string memory) {
        return (dids[did].owner, dids[did].didDocument);
    }
}
