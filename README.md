# Simple Chainlink CCIP

This is a simple Chainlink CCIP that transfer the ERC20 Token from Sepolia to Amoy testnet

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Quickstart

```
git clone https://github.com/cqlyj/simple-chainlink-ccip.git
cd simple-chainlink-ccip
make
```

# Usage

1. Set up your environment variables:

```bash
cp .env.example .env
```

2. Fill in the `.env` file with your own values. And also replace the address anywhere you see in files with your own address.
3. Before running the demo, you need to set up your wallet:

```bash
cast wallet import YOUR_ACCOUNT_NAME --interactive
```

Here I would call it `burner`, and a interactive prompt will show as below:

```bash
    Enter private key:
    Enter password:
    `your-account-name` keystore was saved successfully. Address: address-corresponding-to-private-key
```

Please keep in mind the password you entered, this will be needed for you moving forward with the private key.

And if you change the name from `burner` to something else, you need to update in the `Makefile` as well. Also the `sender` needs to be your address.

```diff
deploy:
-	@forge script script/DeployTokenTransfer.s.sol:DeployTokenTransfer --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv
+   @forge script script/DeployTokenTransfer.s.sol:DeployTokenTransfer --rpc-url $(SEPOLIA_RPC_URL) --account YOUR_ACCOUNT_NAME --sender YOUR_ADDRESS --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv
```

Same for any other command in `Makefile` which ask for your account name and sender addresses.

4. Also update the address in `script/TransferTokenPayNative.s.sol` and `script/WithdrawBalance.s.sol` with your own address.

In `script/TransferTokenPayNative.s.sol`:

```diff
address public constant RECEIVER =
-        0xFB6a372F2F51a002b390D18693075157A459641F;
+        YOUR_ADDRESS;
```

In `script/WithdrawBalance.s.sol`:

```diff
address public constant BENEFICIARY =
-        0xFB6a372F2F51a002b390D18693075157A459641F;
+        YOUR_ADDRESS;
```

5. Run the demo:

```bash
make demo
```

Wait for about 20 mins, and you will get the token in your Amoy testnet account.

## Contact

Luo Yingjie - [luoyingjie0721@gmail.com](luoyingjie0721@gmail.com)
