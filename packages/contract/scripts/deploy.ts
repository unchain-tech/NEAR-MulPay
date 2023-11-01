require('dotenv').config();
const hre = require('hardhat');

const provider = hre.ethers.provider;
const deployerWallet = new hre.ethers.Wallet(
  process.env.AURORA_PRIVATE_KEY,
  provider,
);

async function main() {
  console.log('Deploying contracts with the account:', deployerWallet.address);

  console.log(
    'Account balance:',
    (await deployerWallet.getBalance()).toString(),
  );

  const swapFactory = await hre.ethers.getContractFactory('SwapContract');
  const aoaToken = await hre.ethers.getContractFactory('AuroraToken');
  const daiToken = await hre.ethers.getContractFactory('DaiToken');
  const ethToken = await hre.ethers.getContractFactory('EthToken');
  const maticToken = await hre.ethers.getContractFactory('PolygonToken');
  const shibToken = await hre.ethers.getContractFactory('ShibainuToken');
  const solToken = await hre.ethers.getContractFactory('SolanaToken');
  const uniToken = await hre.ethers.getContractFactory('UniswapToken');
  const usdtToken = await hre.ethers.getContractFactory('TetherToken');

  const SwapContract = await swapFactory.connect(deployerWallet).deploy();
  await SwapContract.deployed();

  const [deployer] = await hre.ethers.getSigners();
  console.log(`deployer address is ${deployer.address}`);

  const AoaToken = await aoaToken.deploy(SwapContract.address);
  const DaiToken = await daiToken.deploy(SwapContract.address);
  const EthToken = await ethToken.deploy(SwapContract.address);
  const MaticToken = await maticToken.deploy(SwapContract.address);
  const ShibToken = await shibToken.deploy(SwapContract.address);
  const SolToken = await solToken.deploy(SwapContract.address);
  const UniToken = await uniToken.deploy(SwapContract.address);
  const UsdtToken = await usdtToken.deploy(SwapContract.address);
  await AoaToken.deployed();
  await DaiToken.deployed();
  await EthToken.deployed();
  await MaticToken.deployed();
  await ShibToken.deployed();
  await SolToken.deployed();
  await UniToken.deployed();
  await UsdtToken.deployed();

  console.log('Swap Contract is deployed to:', SwapContract.address);
  console.log('AoaToken is deployed to:', AoaToken.address);
  console.log('DaiToken is deployed to:', DaiToken.address);
  console.log('EthToken is deployed to:', EthToken.address);
  console.log('MaticToken is deployed to:', MaticToken.address);
  console.log('ShibToken is deployed to:', ShibToken.address);
  console.log('SolToken is deployed to:', SolToken.address);
  console.log('UniToken is deployed to:', UniToken.address);
  console.log('UsdtToken is deployed to:', UsdtToken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
