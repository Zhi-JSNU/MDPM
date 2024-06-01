# MDPM: Metadata Protection Model

## Overview

MDPM (Metadata Protection Model) is a secure communication framework designed for Intelligent Transportation Systems (ITS). It integrates the Communication Metadata Index (CMI) for efficient data transmission and sharing, leveraging attribute-based security mechanisms. Additionally, it incorporates Chaskey Software-Masking (CSM) for enhanced protection against side-channel attacks. The framework is structured to ensure security, speed, granularity, and low latency in data communication processes.

## Features

- **Attribute-Based Security**: Utilizes CPABE for metadata encryption and decryption.
- **Chaskey Software-Masking (CSM)**: Enhances protection against side-channel attacks.
- **Efficient Data Sharing**: Uses a tree-structured CMI for organizing metadata, ensuring manageable metadata volume and facilitating classification and management.
- **Reduced Dependency on Traditional Databases**: Leverages distributed processing and decentralization principles.

## File Structure

- **makeRoot.php**: Script to create the root CMI.
- **function.php**: Contains the main functions for CMI and MDPM operations.
- **keygen.php**: Script for key generation and distribution.
- **download.php**: Handles file download operations.
- **fm.php**: File management functions.
- **searchFile2.php**: Handles search functionality within the CMI.
- **tree.php**: Manages the tree structure of the CMI.
- **userUploadFile.php**: Handles file upload operations.
- **createLst.php**: Script to create list structures for metadata management.

## Installation

1. **Clone the repository**:
   ```bash
   git clone [repository URL]
   cd MDPM-main
