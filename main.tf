data "terraform_remote_state" "vpc" {
  backend = "atlas"

  config {
    name = "azc/network-dev"
  }
}

provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_instance" "foo" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.aws_region}a"

  tags {
    owner = "Adam"
    TTL = 1
  }
  subnet_id = "${data.terraform_remote_state.vpc.app_subnet}"
}