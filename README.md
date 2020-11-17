# Arbitrum Paired ERC-20

## Setup

Add env variables to .env file; to use sample values, run `cp env.sample .env`

## Usage
```bash
# install dependencies
yarn

# Deploy L1 contract and then deploy paired contract on rollup chain
yarn hardhat run scripts/deploy.js --network kovan
>> Token deployed to: 0x8AaBf5dcB496C5c18c33249399B10A3db98C26db
>> Deployed paired contract to L2 chain

# Verify that contract was deployed on L1
yarn hardhat name 0x8AaBf5dcB496C5c18c33249399B10A3db98C26db --network kovan
>> Token Buddy

# Verify that contract was deployed on L2
yarn hardhat name 0x8AaBf5dcB496C5c18c33249399B10A3db98C26db --network arbitrum
>> Token Buddy
```
