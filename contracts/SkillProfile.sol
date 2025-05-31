// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SkillProfile {
    struct Profile {
        string[] teachSkills;
        string[] learnSkills;
        bool exists;
    }

    mapping(address => Profile) private profiles;

    event ProfileUpdated(address indexed user);

    function setProfile(string[] memory _teachSkills, string[] memory _learnSkills) external {
        profiles[msg.sender] = Profile({
            teachSkills: _teachSkills,
            learnSkills: _learnSkills,
            exists: true
        });

        emit ProfileUpdated(msg.sender);
    }

    function getProfile(address user) external view returns (
        string[] memory teachSkills,
        string[] memory learnSkills
    ) {
        require(profiles[user].exists, "Profile does not exist");
        return (
            profiles[user].teachSkills,
            profiles[user].learnSkills
        );
    }

    function updateTeachSkills(string[] memory _newTeachSkills) external {
        require(profiles[msg.sender].exists, "Profile not found");
        profiles[msg.sender].teachSkills = _newTeachSkills;
        emit ProfileUpdated(msg.sender);
    }

    function updateLearnSkills(string[] memory _newLearnSkills) external {
        require(profiles[msg.sender].exists, "Profile not found");
        profiles[msg.sender].learnSkills = _newLearnSkills;
        emit ProfileUpdated(msg.sender);
    }
}
