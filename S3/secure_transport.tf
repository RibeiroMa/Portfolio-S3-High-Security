data "aws_iam_policy_document" "audit_log_base" {
  statement {
    sid     = "AllowSSLRequestsOnly"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
#Politica de bloqueio a conexão inseguras ao bucket, como conexão HTTP, sendo possivel apenas conexões HTTPS

resource "aws_s3_bucket_policy" "data_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.audit_log_base.json
}
