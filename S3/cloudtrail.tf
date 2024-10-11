locals {
  trail_name = "s3-bucket-trail"
  prefix =  "log/"
}

resource "aws_cloudtrail" "trail" {
  name           = local.trail_name
  s3_bucket_name = aws_s3_bucket.log_bucket.id
  s3_key_prefix  = local.prefix
  event_selector {
    read_write_type = "All"
    data_resource {
      type   = "AWS::S3::Object"
      values = ["${aws_s3_bucket.bucket.arn}/"]
    }
  }
}
#Permite o CloudTrail fazer a leitura de todas as ações feitas dentro do seu bucket, como exclusões, alterações e adições


data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

#Politica para o acesso do CloudTrail ao Bucket que está sendo armazenados os Logs
resource "aws_s3_bucket_policy" "log_bucket_policy" {
  bucket = aws_s3_bucket.log_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck20150319"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.log_bucket.arn
        Condition = {
          StringEquals = {
            "aws:SourceArn" = "arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${local.trail_name}"
          }
        }
      },
      {
        Sid    = "AWSCloudTrailWrite20150319"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.log_bucket.id}/${local.prefix}*"
        Condition = {
          StringEquals = { 
            "s3:x-amz-acl"  = "bucket-owner-full-control",
            "aws:SourceArn" = "arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${local.trail_name}"
          }
        }
      }
    ]
  })
}
