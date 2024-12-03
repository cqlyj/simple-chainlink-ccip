-include .env

all : install build

build :; @forge build

demo : deploy send fund allow transfer withdraw

install:
	@forge install smartcontractkit/chainlink-brownie-contracts --no-commit && forge install cyfrin/foundry-devops --no-commit

deploy:
	@forge script script/DeployTokenTransfer.s.sol:DeployTokenTransfer --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv

send:
	@forge script script/SendContractERC20Token.s.sol:SendContractERC20Token --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv

fund:
	@forge script script/FundContractWithNativeEth.s.sol:FundContractWithNativeEth --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv

allow:
	@forge script script/AllowAmoyChain.s.sol:AllowAmoyChain --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv

transfer:
	@forge script script/TransferTokenPayNative.s.sol:TransferTokenPayNative --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv

withdraw:
	@forge script script/WithdrawBalance.s.sol:WithdrawBalance --rpc-url $(SEPOLIA_RPC_URL) --account burner --sender 0xFB6a372F2F51a002b390D18693075157A459641F --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api/ -vvvv
