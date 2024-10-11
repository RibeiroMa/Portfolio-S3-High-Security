resource "aws_kms_key" "mykey" {
  description             = "Chave de criptografia do bucket"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}
