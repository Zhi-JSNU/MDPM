# MDPM: Metadata Protection Model

## Overview

MDPM (Metadata Protection Model) is a secure communication framework designed for Intelligent Transportation Systems (ITS). It integrates the Ciphertex Mapping Index (CMI) for efficient data transmission and sharing, leveraging attribute-based security mechanisms. Additionally, it incorporates Chaskey Software-Masking (CSM) for enhanced protection against side-channel attacks. The framework is structured to ensure security, speed, granularity, and low latency in data communication processes.

## Features

- **Attribute-Based Security**: Utilizes CPABE for metadata encryption and decryption.
- **Chaskey Software-Masking (CSM)**: Enhances protection against side-channel attacks.
- **Efficient Data Sharing**: Uses a tree-structured CMI for organizing metadata, ensuring manageable metadata volume and facilitating classification and management.
- **Reduced Dependency on Traditional Databases**: Leverages distributed processing and decentralization principles.

## File Structure

- **makeRoot.php**: Script to create the root CMI.
- **function.php**: Contains the main functions for CMI and MDPM operations.
- **keygen.php**: Script for key generation and distribution.
- **download.php**: Handles CMI download operations.
- **fm.php**: Metadata management functions.
- **searchFile2.php**: Handles search functionality within the CMI.
- **tree.php**: Manages the tree structure of the CMI.
- **userUploadFile.php**: Handles CMI upload operations.
- **createLst.php**: Script to create list structures for metadata management.

## Installation

1. **Clone the repository**:
   ```bash
   git clone [repository URL]
   cd MDPM-main

2. **Set up your PHP environment**:
   
   ```bash
   Ensure you have a working PHP environment. You can use XAMPP, WAMP, or any other PHP server.
3. **SCreate the root CMI**:
   Run makeRoot.php to initialize the root CMI structure.
   ```bash
   php makeRoot.phpUsage

## Usage

1. **Creating the Root CMI.**

   ```bash
   Run the makeRoot.php
   php makeRoot.php

2. **Key Generation**

   ```bash
   Generate keys using keygen.php:
   php keygen.php

3. **Upload metadata**

   ```bash
   Use userUploadFile.php to upload metadata to the CMI:
   php userUploadFile.php

4. **Retrieve metadata**

   ```bash
   Retrieve metadata within the CMI using searchFile2.php:
