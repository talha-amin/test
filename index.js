const Moralis = require("moralis").default;
const { EvmChain } = require("@moralisweb3/common-evm-utils");

const runApp = async () => {
  await Moralis.start({
    apiKey: "fMrKMcnjjXvm427SMi6sxuAba2gQKQItwYM4eVU1N61e217T0hZuajT5LxOmu0Pv",
  });
  
  const address = "0xaF4c3a871b85d9520d6ADe67deF7acCa7c795a3E";

  const chain = EvmChain.GOERLI;
  
  const response = await Moralis.EvmApi.nft.getContractNFTs({
    address,
    chain,
  });
  
  console.log(response);
}

runApp();