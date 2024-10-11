resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id
  
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
#aplica criptografia ao bucket por meio de chave kms

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [aws_s3_bucket_ownership_controls.owner]

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}
#bloqueia acesso publico ao bucket, segue a regua imposta de ownership controls