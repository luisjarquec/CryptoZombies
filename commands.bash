#Install truffle on local computer
npm install truffle -g

#Initialise truffle & download trasaction signing tool
truffle init
npm install truffle-hdwallet-provider -g

#Copy all contracts to 'contracts' folder on truffle
#Execute truffle
truffle compile

#Modify initial_migration so that it interacts with CryptoZombies
#JS
var CryptoZombies = artifacts.require("./CryptoZombies");
module.exports = function(deployer) {
    deployer.deploy(CryptoZombies);
};



