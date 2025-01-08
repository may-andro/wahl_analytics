# Purpose

CLI tool for uploading data in the [Cloud Firestore](https://firebase.google.com/docs/firestore/).

# Introduction

- This is a dart CLI tool used for the uploading the JSON files to firestore.
- Download the service account from your Firebase project settings, then save it under `tools\data\credentials`.
- The JSON files to upload are under `tools\data\firestore`
- The project uses Firebase API to communicate with the Firestore.

# Usage

## Command templates

`dart run bin/firestore_file_uploader.dart upload --env <env> --credentials <file_path> --data <file_path>`

### Commands for `Staging`

`dart run bin/firestore_content_uploader.dart upload --env staging --document business_client --credentials ../data/credentials/service_account.json --data ../data/firestore/staging/section_business_client.json`
`dart run bin/firestore_content_uploader.dart upload --env staging --document business_contact --credentials ../data/credentials/service_account.json --data ../data/firestore/staging/section_business_contact.json`
`dart run bin/firestore_content_uploader.dart upload --env staging --document business_info --credentials ../data/credentials/service_account.json --data ../data/firestore/staging/section_business_info.json`
`dart run bin/firestore_content_uploader.dart upload --env staging --document business_service --credentials ../data/credentials/service_account.json --data ../data/firestore/staging/section_business_service.json`
`dart run bin/firestore_content_uploader.dart upload --env staging --document business_team --credentials ../data/credentials/service_account.json --data ../data/firestore/staging/section_business_team.json`

### Commands for `Prod`

`dart run bin/firestore_content_uploader.dart upload --env prod --document business_client --credentials ../data/credentials/service_account.json --data ../data/firestore/prod/section_business_client.json`
`dart run bin/firestore_content_uploader.dart upload --env prod --document business_contact --credentials ../data/credentials/service_account.json --data ../data/firestore/prod/section_business_contact.json`
`dart run bin/firestore_content_uploader.dart upload --env prod --document business_info --credentials ../data/credentials/service_account.json --data ../data/firestore/prod/section_business_info.json`
`dart run bin/firestore_content_uploader.dart upload --env prod --document business_service --credentials ../data/credentials/service_account.json --data ../data/firestore/prod/section_business_service.json`
`dart run bin/firestore_content_uploader.dart upload --env prod --document business_team --credentials ../data/credentials/service_account.json --data ../data/firestore/prod/section_business_team.json`
