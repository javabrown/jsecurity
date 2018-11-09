provider "aws" {
  region     = "${var.aws_region}"
//  access_key = "${var.aws_access_key_id}"
//  secret_key = "${var.aws_secret_access_key}"

  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_access_id}"

  // shared_credentials_file = "C:/Users/rkhan/.aws"
  // profile = "customprofile"
}
