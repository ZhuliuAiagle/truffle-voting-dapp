pragma solidity ^0.5.0;


contract Commenting {

    struct Proposal {
        string title;
        uint commentCountPos;
        uint commentCountNeg;
        uint commentCountAbs;
        mapping (address => loginUser) loginUsers;
        address[] loginUsersAddress;
    }

    struct loginUser {
        uint value;
        bool commentd;
    }

    Proposal[] public proposals;

    event CreatedProposalEvent();
    event CreatedCommentEvent();

    function getNumProposals() public view returns (uint) {
        return proposals.length;
    }

    function getProposal(uint proposalInt) public view returns (uint, string memory, uint, uint, uint, address[] memory, bool) {
        if (proposals.length > 0) {
            Proposal storage p = proposals[proposalInt]; // Get the proposal
            return (proposalInt, p.title, p.commentCountPos, p.commentCountNeg, p.commentCountAbs, p.loginUsersAddress, p.loginUsers[msg.sender].commentd);
        }
    }

    function addProposal(string memory title) public returns (bool) {
        Proposal memory proposal;
        emit CreatedProposalEvent();
        proposal.title = title;
        proposals.push(proposal);
        return true;
    }

    function comment(uint proposalInt, uint commentValue) public returns (bool) {
        if (proposals[proposalInt].loginUsers[msg.sender].commentd == false) { // check duplicate key
            require(commentValue == 1 || commentValue == 2 || commentValue == 3); // check commentValue
            Proposal storage p = proposals[proposalInt]; // Get the proposal
            if (commentValue == 1) {
                p.commentCountPos += 1;
            } else if (commentValue == 2) {
                p.commentCountNeg += 1;
            } else {
                p.commentCountAbs += 1;
            }
            p.loginUsers[msg.sender].value = commentValue;
            p.loginUsers[msg.sender].commentd = true;
            p.loginUsersAddress.push(msg.sender);
            emit CreatedCommentEvent();
            return true;
        } else {
            return false;
        }
    }

}
