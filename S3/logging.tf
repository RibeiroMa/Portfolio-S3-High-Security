resource "aws_s3_bucket" "log_bucket" {
  bucket = "cloudquery-good-log-bucket"
}
#criação do bucket usado para armazenamento de logs

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.bucket.id
  #apontamento do bucket onde os logs serão coletados

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
  #bucket que será armazenado os logs
}
