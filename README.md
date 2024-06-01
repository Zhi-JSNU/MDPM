MDPM: Metadata Protection Model
Overview
MDPM (Metadata Protection Model) is a secure communication framework designed for Intelligent Transportation Systems (ITS). It integrates the Communication Metadata Index (CMI) for efficient data transmission and sharing, leveraging attribute-based security mechanisms. Additionally, it incorporates Chaskey Software-Masking (CSM) for enhanced protection against side-channel attacks. The framework is structured to ensure security, speed, granularity, and low latency in data communication processes.

Features
Attribute-Based Security: Utilizes CPABE for metadata encryption and decryption.
Chaskey Software-Masking (CSM): Enhances protection against side-channel attacks.
Efficient Data Sharing: Uses a tree-structured CMI for organizing metadata, ensuring manageable metadata volume and facilitating classification and management.
Reduced Dependency on Traditional Databases: Leverages distributed processing and decentralization principles.
File Structure
makeRoot.php: Script to create the root CMI.
function.php: Contains the main functions for CMI and MDPM operations.
keygen.php: Script for key generation and distribution.
download.php: Handles file download operations.
fm.php: File management functions.
searchFile2.php: Handles search functionality within the CMI.
tree.php: Manages the tree structure of the CMI.
userUploadFile.php: Handles file upload operations.
createLst.php: Script to create list structures for metadata management.
Installation
Clone the repository:

bash
复制代码
git clone [repository URL]
cd MDPM-main
Set up your PHP environment:
Ensure you have a working PHP environment. You can use XAMPP, WAMP, or any other PHP server.

Create the root CMI:
Run makeRoot.php to initialize the root CMI structure.

bash
复制代码
php makeRoot.php
Usage
Creating the Root CMI
Run the root creation script:
bash
复制代码
php makeRoot.php
Key Generation
Generate keys using keygen.php:
bash
复制代码
php keygen.php
Uploading Files
Use userUploadFile.php to upload files to the CMI:
bash
复制代码
php userUploadFile.php
Searching Files
Search files within the CMI using searchFile2.php:
bash
复制代码
php searchFile2.php
Downloading Files
Download files using download.php:
bash
复制代码
php download.php
Security Features
Random Insertion (RI) and Uniform Distribution Insertion (UDI)
To enhance instruction protection strategies, MDPM implements two techniques for inserting no-operation (NOP) instructions:

Random Insertion (RI): Inserts NOP instructions at unpredictable positions and in varying quantities to thwart side-channel attacks.
Uniform Distribution Insertion (UDI): Uniformly inserts NOP instructions during critical operations to balance execution time and energy consumption.
Integration with CMI
Initialization Parameter Retrieval:

Retrieve NOP insertion method and parameters by decrypting the metadata block stored in the CMI.
Execution of RI:

Retrieve random seed from the CMI.
Generate random sequence for NOP insertion positions and quantities.
Insert NOP instructions at random positions.
Execution of UDI:

Retrieve insertion interval parameter from the CMI.
Insert NOP instructions uniformly within the instruction stream.
Instruction Stream Execution:

Execute the instruction stream with inserted NOP instructions.
Record and share NOP insertion methods and parameters through the CMI framework.
Experimental Validation
Our experiments demonstrate that the CMI method, particularly with the integration of CSM, meets the performance demands of current and future Intelligent Vehicle (IV) communications. The results indicate that:

RI: Significantly increases the difficulty of side-channel attacks with minimal performance impact.
UDI: Effectively balances execution time and energy consumption, enhancing resistance to side-channel attacks.
Future Work
Future research will focus on integrating AI technologies within the MDPM framework to further enhance system intelligence and responsiveness.



Contact
For any queries or further information, please contact:

[Qiang Zhi]
[zhiqiang0728(gmail)]
