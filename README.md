# Encrypt-Google-Drive-Stream-Upload

A super lightweight and memory efficient bash script to encrypt a file/folder and then upload the encrypted file to your Google Drive account. It follows the following procedures,

1) Archive the file/folder using `tar`.
2) Encrypt the archived `.tar` file using `gpg`.
3) Upload the resulting `.gpg` file.

which normally requires space on the hard drive to be allocated first for the `.tar` archive, and then the `.gpg` file, which is just under double the file/folder's original size.

The script does the 3 steps above by piping through a stream of data from the file/folder and does the above 3 steps. This saves hard drive space as well as CPU/Memory requirements. In fact, the amount of memory used at any given time is only around 1 MB of RAM, with no physical space required. This means if your hard drive is almost full, you can still archive, encrypt, and upload without needing to worry about creating space for the archive and encryption file.

The data is encrypted before it leaves your computer, making your uploads private. A decryption file is provided as well.

## Setup and Requirements
- This script uses `grep`, `sed`, `perl`, `tar`, `curl`, and `gpg` commands. The script is written to use the same options within each command, so it will work for most Linux distributions and Mac OS. All commands are normally available by default, except for the `gpg` command. This can be installed in Ubuntu: `sudo apt-get install gnupg` and in MacOS: `brew install gnupg`.
- This script (using Google Drive API v3) requires you to input your `client_id`, `client_secret`, and `refresh_token` for your Google Account. For testing, you can get these variables at https://developers.google.com/oauthplayground/. For more regular usage (doesn't require to to constantly get an oauth token), you can register an application with Google [enabling Google Drive API on Google Cloud](https://developers.google.com/drive/api/v3/enable-drive-api).

## Usage

- To encrypt a file: `./StreamGDriveUpload.sh "File/Folder Name"`.
  - A prompt will come up, asking you to enter your password twice. Afterwards, the upload initiates.

- To decrypt a file: `./decryptStreamGDriveUpload.sh "Encrypted File/Folder Name.gpg"`.
  - If you originally encrypted a folder, a decrypted folder will appear after in your working directory. If it was a file, the file appears instead.
