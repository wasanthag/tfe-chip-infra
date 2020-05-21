resource "tls_private_key" "wg_key" {
  algorithm   = "RSA"
#  algorithm   = "ECDSA"
#  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "tfe-cert" {
  #key_algorithm   = "ECDSA"
  #private_key_pem = file("private_key.pem")
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.wg_key.private_key_pem}"

  subject {
    common_name  = "tfe-aws01.example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 720

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

