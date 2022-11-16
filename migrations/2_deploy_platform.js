const Prode = artifacts.require('Prode');

module.exports = async function (deployer) {
    deployer.deploy(Prode);
};
