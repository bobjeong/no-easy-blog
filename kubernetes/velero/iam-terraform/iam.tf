resource "aws_iam_user" "velero" {
  name = "velero"

  tags = {
    velero = "velero-backup-user"
  }
}

resource "aws_iam_access_key" "velero_access_key" {
  user = aws_iam_user.velero.name
}

resource "aws_iam_user_policy" "velero_policy" {
  name = "velero-backup-role"
  user = aws_iam_user.velero.name

  policy =  jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:CreateSnapshot",
          "ec2:DeleteSnapshot"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:PutObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts"
        ],
        Resource = [
          "${module.s3_bucket.s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource: [
          module.s3_bucket.s3_bucket_arn
        ]
      }
    ]
  })
}

resource "local_file" "velero_credentials" {
  content              = "[default]\naws_access_key_id=${aws_iam_access_key.velero_access_key.id}\naws_secret_access_key=${aws_iam_access_key.velero_access_key.secret}"
  filename             = "${path.module}/velero-credentials"
  file_permission      = "0600"
  directory_permission = "0755"
}