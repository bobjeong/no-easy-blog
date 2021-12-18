
## Create Iam User Velero
```
# terraform verion 1.1.1
terraform init

terraform plan

terraform apply # (yes)

# create velero user credential path is .
```

## Create Velero Kubernetes Resource
```
velero install \
  --provider aws \
  --plugins velero/velero-plugin-for-aws:v1.3.0 \
  --bucket ${YOUR_BUCKET_NAME} \
  --backup-location-config region=${YOUR_BUCKET_REGION} \
  --snapshot-location-config region=${YOUR_BUCKET_REGION} \
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


## Delete
```
terraform destroy # (yes)

velero uninstall
```