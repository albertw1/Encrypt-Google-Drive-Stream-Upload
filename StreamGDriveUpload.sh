#!/bin/bash
# Written for Ubuntu and Mac OS.

# Inputs
# client_id, client_secret, and refresh_token may be obtained from https://developers.google.com/oauthplayground/
# for more permanent auth credentials, go to https://developers.google.com/drive/api/v3/enable-drive-api
file_name="$1"
client_id=""
client_secret=""
refresh_token=""

gpgconf --kill gpg-agent
export GPG_TTY=$(tty)
folder_name="root"
scope="https://www.googleapis.com/auth/drive.readonly+https://www.googleapis.com/auth/drive.file"

obtain_token=$(curl \
    --silent \
    --data "client_id="${client_id}"&client_secret="${client_secret}"&refresh_token="${refresh_token}"&grant_type=refresh_token" \
    "https://accounts.google.com/o/oauth2/token")

access_token=$(echo "${obtain_token}" | grep "access_token" | sed -e 's/\"access_token\": \"\(.*\)\",/\1/')
base_filename=$(basename "${file_name}")
mime_attribute=$(file --brief --mime-type "${file_name}")
data_payload="{\"mimeType\": \""${mime_attribute}"\",
                \"name\": \""${base_filename}".gpg\",
                \"parents\": [\""${folder_name}"\"],
                \"originalFilename\": \""${base_filename}".gpg\"}"

post_upload=$(curl \
    --silent \
    -X POST \
    -H "Host: www.googleapis.com" \
    -H "Authorization: Bearer ${access_token}" \
    -H "Content-Type: application/json; charset=UTF-8" \
    -H "X-Upload-Content-Type: ${mime_attribute}" \
    -d "${data_payload}" \
    "https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable" \
    --dump-header - | perl -ne 'print m[ocation: ([^\r\n]*)]')

echo -e "\nUploading File: '${file_name}' to Google Drive...\n"

tar cf - "${file_name}" | gpg -c --cipher-algo AES256 --compress-algo none -o - \
    | curl --silent -T - \
    -X PUT \
    -H "Authorization: Bearer ${access_token}" \
    --output /dev/null \
    "${post_upload}" \


