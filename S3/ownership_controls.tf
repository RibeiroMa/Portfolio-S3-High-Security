resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred" #Condição que o criador do bucket tem total acesso aos arquivos
  }                                           #Porem quem o envio tambem continua tendo acesso
}