# SkillLoop Blockchain

**SkillLoop** is a decentralized platform that facilitates peer-to-peer skill exchange using blockchain. This repo contains the smart contracts and scripts powering the core mechanics of the SkillLoop system.

## Contracts Overview

| Contract        | Type     | Purpose                                           |
|-----------------|----------|---------------------------------------------------|
| `SkillToken`    | ERC20    | Utility token used to pay for learning sessions   |
| `SkillEscrow`   | Custom   | Escrow contract to manage session-based payments  |
| `SkillBadgeNFT` | ERC721   | NFT certificate issued after completed sessions   |
| `SkillProfile`  | (Optional) | On-chain user profile with skills & preferences |

---

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/yourusername/skillloop-blockchain.git
cd skillloop-blockchain
```

### 2. Install dependencies

```bash
npm install
```

### 3. Set up environment variables

Create a `.env` file:

```env
PRIVATE_KEY=your_wallet_private_key
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_PROJECT_ID
ETHERSCAN_API_KEY=your_etherscan_api_key
```

> Never commit your `.env` file.

---

## Hardhat Tasks

### Compile contracts

```bash
npx hardhat compile
```

### Run tests

```bash
npx hardhat test
```

### Deploy locally

```bash
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
```

### Deploy to Sepolia

```bash
npx hardhat run scripts/deploy.js --network sepolia
```

---

## Contracts

### SkillToken (ERC20)

- `faucet(address to, uint amount)`: Mint test tokens
- `mint(address to, uint amount)`: Admin-only minting
- Used for paying session fees

### SkillEscrow

- `createSession(address teacher, uint fee)`: Learner starts session
- `confirmSession(uint sessionId)`: Teacher confirms & receives payment

### SkillBadgeNFT

- `mint(address to, string memory metadataURI)`: Issues NFT certificate

### SkillProfile (optional)

- Stores skill tags, preferences (TBD)

---

## Helper Scripts

All scripts live in the `scripts/` directory.

| Script             | Description                             |
|--------------------|-----------------------------------------|
| `faucet.js`         | Give SKT tokens to an address           |
| `createSession.js`  | Create a test session in escrow         |
| `completeSession.js`| Confirm a session & release funds       |
| `mintBadge.js`      | Mint a certificate NFT after session    |
| `exportABI.js`      | Save ABI and address JSON for frontend  |

Run a script:

```bash
npx hardhat run scripts/faucet.js --network sepolia
```

---

## Export for Frontend

After deployment, run:

```bash
node scripts/exportABI.js
```

Exports:

- `frontend-exports/abis.json`
- `frontend-exports/addresses.json`

---

## License

MIT © 2025 SkillLoop Contributors

---

## Author

Built by Yusasive as part of the SkillLoop Innovation Project at **University of Ilorin**.
