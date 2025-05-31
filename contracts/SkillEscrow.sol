// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SkillEscrow is Ownable {
    IERC20 public skillToken;
    uint256 public sessionCounter;

    enum SessionStatus { Pending, Confirmed, Completed, Cancelled }

    struct Session {
        address learner;
        address teacher;
        uint256 amount;
        SessionStatus status;
    }

    mapping(uint256 => Session) public sessions;

    event SessionCreated(uint256 sessionId, address learner, address teacher, uint256 amount);
    event SessionConfirmed(uint256 sessionId);
    event SessionCompleted(uint256 sessionId);
    event SessionCancelled(uint256 sessionId);

    constructor(address _skillToken) Ownable(msg.sender) {
        skillToken = IERC20(_skillToken);
    }

    function createSession(address _teacher, uint256 _amount) external returns (uint256) {
        require(_teacher != address(0), "Invalid teacher");
        require(_amount > 0, "Amount must be > 0");

        sessionCounter++;

        require(skillToken.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");

        sessions[sessionCounter] = Session({
            learner: msg.sender,
            teacher: _teacher,
            amount: _amount,
            status: SessionStatus.Pending
        });

        emit SessionCreated(sessionCounter, msg.sender, _teacher, _amount);
        return sessionCounter;
    }

    function confirmSession(uint256 _sessionId) external {
        Session storage session = sessions[_sessionId];
        require(msg.sender == session.teacher, "Only teacher can confirm");
        require(session.status == SessionStatus.Pending, "Session not pending");

        session.status = SessionStatus.Confirmed;
        emit SessionConfirmed(_sessionId);
    }

    function completeSession(uint256 _sessionId) external {
        Session storage session = sessions[_sessionId];
        require(msg.sender == session.learner, "Only learner can complete");
        require(session.status == SessionStatus.Confirmed, "Session not confirmed");

        session.status = SessionStatus.Completed;
        require(skillToken.transfer(session.teacher, session.amount), "Payment failed");

        emit SessionCompleted(_sessionId);
    }

    function cancelSession(uint256 _sessionId) external {
        Session storage session = sessions[_sessionId];
        require(msg.sender == session.learner, "Only learner can cancel");
        require(session.status == SessionStatus.Pending, "Cannot cancel after confirmation");

        session.status = SessionStatus.Cancelled;
        require(skillToken.transfer(session.learner, session.amount), "Refund failed");

        emit SessionCancelled(_sessionId);
    }
}
