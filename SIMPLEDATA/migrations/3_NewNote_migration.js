const NewNote = artifacts.require("NewNote");

module.exports = function (deployer) {
  deployer.deploy(NewNote);
};