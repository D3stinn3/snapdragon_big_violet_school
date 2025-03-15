# ZPass Merkle 8 Family - Aleo Smart Contract

## Overview
The `zpass_merkle_8_family.aleo` program is a **privacy-preserving identity verification** system designed for hierarchical family-based ZPass credentials. Using **Merkle trees and Zero-Knowledge Proofs (ZKPs)**, this program allows for the issuance of **Master ZPasses** (ZPass X) that represent a family lineage and **Child ZPasses** that are cryptographically linked to their Master.

## Deployment Details
- **Contract Name**: `zpass_merkle_8_family.aleo`
- **Deployed on**: Aleo Testnet
- **Transaction Hash**: `at1r5t50cxrvg5zs72usrarje9w7dacepa9wk3vttpc3nwskx93gqfqgrxkc6`

## Features
- **Master ZPass Issuance (ZPass X)**: Creates a root family identity using Merkle trees.
- **Child ZPass Issuance**: Allows the addition of new family members under a Master ZPass.
- **Verification of Parent-Child Relationships**: Ensures that a Child ZPass is cryptographically linked to its Master ZPass.
- **Merkle Tree Computation**: Uses `Poseidon2` hashing to securely aggregate family-related credentials.

## Data Structures
### **ZPass Record**
```leo
record ZPass {
    owner: address,
    issuer: address,
    root: field,
}
```
- `owner`: Address of the credential holder.
- `issuer`: Address of the entity that issued the ZPass.
- `root`: Merkle root representing the hashed family data.

## Program Functions
### **1. `issue_master`**
```leo
transition issue(
    private sig: signature,
    private leaves_hashes: [field; 8],
    private issuer: address
) -> ZPass
```
#### **Description**
- Issues a **Master ZPass (ZPass X)** containing the family name.
- Generates a **Merkle root** from the provided credential data.
- Validates the issuer's signature to ensure authenticity.

#### **Parameters**
- `sig`: The issuer's signature.
- `leaves_hashes`: The hashed fields forming the Merkle tree.
- `issuer`: The issuing entity.

#### **Returns**
- `ZPass`: A new Master ZPass credential.

### **2. `issue_child`**
```leo
transition issue_child(
    private sig: signature,
    private master_zpass: ZPass,
    private leaves_hashes: [field; 8],
    private issuer: address
) -> ZPass
```
#### **Description**
- Issues a **Child ZPass** under an existing **Master ZPass (ZPass X)**.
- Uses **Merkle proofs** to ensure the child is cryptographically linked to the Master ZPass.

#### **Parameters**
- `sig`: The issuer’s signature.
- `master_zpass`: The parent ZPass X record.
- `leaves_hashes`: The hashed fields forming the Merkle tree.
- `issuer`: The entity issuing the child ZPass.

#### **Returns**
- `ZPass`: A new Child ZPass credential.

### **3. `verify_child_belongs_to_master`**
```leo
transition verify_child_belongs_to_master(
    master_zpass: ZPass,
    child_zpass: ZPass,
    merkle_proof: [field; 3]
) -> bool
```
#### **Description**
- Verifies that a **Child ZPass** is cryptographically linked to a **Master ZPass**.
- Uses Merkle proofs to confirm validity.

#### **Parameters**
- `master_zpass`: The ZPass X credential (Master).
- `child_zpass`: The ZPass credential of the individual (Child).
- `merkle_proof`: The proof required for verification.

#### **Returns**
- `bool`: **True** if the child belongs to the master, **False** otherwise.

## Security Considerations
- **ZK Proofs for Verification**: Ensures that a child belongs to a master without exposing sensitive family data.
- **Immutable Credential Storage**: All issued credentials are stored as cryptographic hashes, preventing tampering.
- **Decentralized Verification**: No need for centralized identity providers—families can verify relationships on-chain.

## How to Deploy & Interact
### **1. Deploy the Program**
Ensure you have **Aleo CLI** installed and run:
```sh
leo build
leo deploy
```

### **2. Issue a Master ZPass**
```sh
leo run issue_master <signature> <hashed_data> <issuer_address>
```

### **3. Issue a Child ZPass**
```sh
leo run issue_child <signature> <master_zpass> <hashed_data> <issuer_address>
```

### **4. Verify Parent-Child Relationship**
```sh
leo run verify_child_belongs_to_master <master_zpass> <child_zpass> <merkle_proof>
```

## Conclusion
The `zpass_merkle_8_family.aleo` program enables **privacy-preserving, hierarchical family identity verification** on the Aleo blockchain. By leveraging **Zero-Knowledge Proofs (ZKPs)** and **Merkle trees**, families can securely store and verify lineage data without compromising privacy.

🚀 **Next Steps**
- Extend the program to support **multi-generational family structures**.
- Implement **delegated verification rights** for family heads.
- Integrate with **off-chain family records** using zk-SNARK proofs.


