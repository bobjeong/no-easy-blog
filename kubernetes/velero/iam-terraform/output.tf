output "aws_iam_user_arn" {
  value = aws_iam_user.velero.arn
}

output "s3_bucket_id" {
  value = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_region" {
  value = module.s3_bucket.s3_bucket_region
}