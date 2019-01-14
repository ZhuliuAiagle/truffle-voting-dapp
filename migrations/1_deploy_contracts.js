var Commenting = artifacts.require("./Commenting.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Commenting);
};
