
## Create Iam User Velero
```
terraform init //terraform verion 1.1.1

// create velero user credential path is .
```

## Create Velero Kubernetes Resource
```
velero install \
  --provider aws \
  --plugins velero/velero-plugin-for-aws:v1.3.0 \
  --bucket ${YOUR_BUCKER_NAME} \
  --backup-location-config region=${YOUR-BUCKER_REGION} \
  --snapshot-location-config region=${YOUR-BUCKER_REGION} \
  --secret-file ${YOUR_AWS_CREDENTIALS_PATH} \
  --velero-pod-cpu-limit 2 \
  --velero-pod-mem-limit 4G
```

## Backup
```
velero backup create ${BACKUP_DIRECTORY_NAME} --include-namespaces ${BACKUP_NAMESPACE}
```

## Restore
```
velero restore create ${RESTORE_DIRECTORY_NAME} --from-backup ${BACKUP_DIRECTORY_NAME}
```