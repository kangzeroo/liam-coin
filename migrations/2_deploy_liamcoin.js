// truffle way of deploying
const LiamCoin = artifacts.require('LiamCoin');

module.exports = async (deployer) => {
  console.log("Deploying LiamCoin...");
  await deployer.deploy(LiamCoin, "LiamCoin", 'SLAM', 18);
  const token = await LiamCoin.deployed();
  console.log("LiamCoin deployed at: " + token.address);
  await token._mint(LiamCoin.address, 1000000);
  console.log("LiamCoin minted 1000000 tokens");
};
