resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true #Impede a aplicação de ACL que permitam acesso publico ao bucket
  block_public_policy     = true #Impede a utilização de politicas que liberem acesso publico ao bucket
  ignore_public_acls      = true #Caso alguma ACL publica for aplicada ao bucket será ignorada
  restrict_public_buckets = true #Independente de qualquer ACL ou politica, bloqueia o acesso publico ao bucket
}
