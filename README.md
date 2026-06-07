# 🎟️ Automated & Verifiable Raffle Smart Contract

A secure, autonomous, and provably fair lottery smart contract written in Solidity. This contract leverages **Chainlink VRF V2 Plus** for untamperable randomness and **Chainlink Automation** for hands-free, time-based execution.

This contract strictly follows the official Solidity style guide and standard practices for production-ready smart contracts.

---

## 🛠️ Key Features

* **Provably Fair:** Employs Chainlink Verifiable Random Function (VRF) to guarantee that every winner is picked with tamper-proof randomness.
* **100% Autonomous:** Uses Chainlink Automation to continuously check conditions and trigger the lottery drawing without human intervention.
* **Gas Optimized:** Implements modern custom errors (`error Raffle__...`) instead of gas-heavy `require` strings.
* **Strict Architecture:** Adheres to a strict structural layout (Errors -> State Variables -> Events -> Functions) making it incredibly easy to audit and read.

---

## 🏗️ How It Works (The Lifecycle)

The raffle operates in a continuous, automated loop:

1. **Players Enter:** Users call `enterRaffle()` and pay the exact `i_entranceFee`. Their addresses are saved in the `s_players` array.
2. **Automation Check:** Chainlink nodes constantly evaluate `checkUpkeep()`. It automatically returns `true` only when:
   * The configured time `i_interval` has passed.
   * The contract has at least one player and some ETH.
   * The lottery is currently `OPEN`.
3. **Randomness Request:** Once ready, the node automatically calls `performUpkeep()`. The contract locks down (`CALCULATING` state) and requests a random number from Chainlink VRF.
4. **Payout & Reset:** Chainlink VRF responds via `fulfillRandomWords()`. The contract uses the random number to pick a winner, transfers the entire vault balance to them, resets the player pool, and flips the state back to `OPEN`.

---

## 📊 Core Configurations & State

| Variable Name | Type | Description |
| :--- | :--- | :--- |
| `i_entranceFee` | `uint256` | The exact ticket price required to enter the raffle (in Wei). |
| `i_interval` | `uint256` | The duration (in seconds) that each raffle round lasts. |
| `s_raffleState` | `enum` | Tracks if the raffle is currently `OPEN` (0) or `CALCULATING` (1). |
| `i_subscriptionId` | `uint256` | The funded Chainlink VRF subscription ID used to pay for randomness. |

---

## 🚀 Local Setup & Deployment

### 1. Prerequisites
Make sure you have your smart contract development framework installed (Foundry or Hardhat) along with the Chainlink contracts library:

```bash
# For Foundry users
forge install smartcontractkit/chainlink-brownie-contracts --no-commit