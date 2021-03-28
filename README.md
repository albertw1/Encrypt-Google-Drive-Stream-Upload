# Encrypt-Google-Drive-Stream-Upload

A super lightweight and memory efficient bash script to encrypt a file/folder and then upload the encrypted file to your Google Drive account. It follows the following procedures,

1) Archive the file/folder using `tar`.
2) Encrypt the archived `.tar` file using `gpg`.
3) Upload the resulting `.gpg` file.

which normally requires space on the hard drive to be allocated first for the `.tar` archive, and then the `.gpg` file, which is just under double the file/folder's original size.

The script does the 3 steps above by piping through a stream of data from the file/folder and does the above 3 steps. This saves hard drive space as well as CPU/Memory requirements. In fact, the amount of memory used at any given time is only around 1 MB of RAM, with no physical space required. This means if your hard drive is almost full, you can still archive, encrypt, and upload without needing to worry about creating space for the archive and encryption file.

The data is encrypted before it leaves your computer, making your uploads private. A decryption file is provided as well.

## Setup
- This script (using Google Drive API v3) requires you to input your `client_id`, `client_secret`, and `refresh_token` for your Google Account. For testing, you can get these variables at https://developers.google.com/oauthplayground/. For more regular usage, you can register an application with Google [enabling Google Drive API on Google Cloud](https://developers.google.com/drive/api/v3/enable-drive-api).

## Usage

- To encrypt a file: `./StreamGDriveUpload.sh "File or Folder Name"`.
  - A password prompt will come up.

- To decrypt a file: `./decryptStreamGDriveUpload.sh "EncryptedFile.gpg"`.
