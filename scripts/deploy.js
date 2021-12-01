// hardhat way of deploying

const hre = require("hardhat");
const { ethers } = hre;

async function main() {
    await hre.run('compile');
    console.log("compiled");
    console.log(process.env.PROD_WALLET_PRIVATE_KEY)
    const SLAM = await ethers.getContractFactory('LiamCoin');
    const slam = await SLAM.deploy();
    console.log('LiamCoin deployed at: ' + slam.address)
    await slam.mint(slam.address, 1000000);
    console.log('LiamCoin minted 1000000 tokens')
    // await slam.transfer(deployer.address, 5000);
    // console.log('LiamCoin transferred 5000 tokens to the deployer')
}

main()
    .then(() => process.exit())
    .catch(error => {
        console.error(error);
        process.exit(1);
})