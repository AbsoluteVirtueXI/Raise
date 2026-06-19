-include .env

ANVIL_RPC_URL ?= http://127.0.0.1:8545
ANVIL_DEPLOYER_ACCOUNT ?= anvilDeployer
SEPOLIA_DEPLOYER_ACCOUNT ?= sepoliaDeployer
DEPLOY_SCRIPT := script/DeployRaise.s.sol:DeployRaiseScript
RAISE_CONTRACT := src/Raise.sol

.PHONY: install forge-install clean build fmt test coverage gas-report snapshot snapshot-check storage-layout dry-deploy-anvil deploy-anvil dry-deploy-sepolia deploy-sepolia

install:
	git submodule update --init --recursive

forge-install:
	forge install foundry-rs/forge-std
	forge install openzeppelin/openzeppelin-contracts
	forge install smartcontractkit/chainlink-evm@contracts-v1.5.0

clean:
	forge clean

build:
	forge build

fmt:
	forge fmt

test:
	forge test

coverage:
	forge coverage --contracts src --match-contract "Raise" \
	--no-match-coverage "script/|test/|src/examples/"

gas-report:
	forge test --gas-report

snapshot:
	forge snapshot

snapshot-check:
	forge snapshot --check

storage-layout:
	forge inspect $(RAISE_CONTRACT):Raise storageLayout

dry-deploy-anvil:
	forge script $(DEPLOY_SCRIPT) \
		--rpc-url $(ANVIL_RPC_URL) \
		--account $(ANVIL_DEPLOYER_ACCOUNT)

deploy-anvil:
	forge script $(DEPLOY_SCRIPT) \
		--broadcast \
		--rpc-url $(ANVIL_RPC_URL) \
		--account $(ANVIL_DEPLOYER_ACCOUNT)

dry-deploy-sepolia:
	forge script $(DEPLOY_SCRIPT) \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--account $(SEPOLIA_DEPLOYER_ACCOUNT) -vvvvv

deploy-sepolia:
	forge script $(DEPLOY_SCRIPT) \
		--broadcast \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--verify --etherscan-api-key $(ETHERSCAN_API_KEY) \
		--account $(SEPOLIA_DEPLOYER_ACCOUNT) -vvvvv
