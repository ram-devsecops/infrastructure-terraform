# Create IAM policy: s3_readonly
module "iam" {
  source        = "./iam"
  iam_profile_name  = "${var.iam_profile_name}"
}

# Create S3 bucket to be the home for our public keys
resource "aws_s3_bucket" "ssh" {
  bucket_prefix = "${var.bucket_prefix}"
  acl           = "public-read"
  force_destroy = "${var.s3_bucket_force_destroy}"

  tags {
    Terraform   = "true"
    Name        = "Bastion SSH Keys for ${var.environment}"
    Environment = "${var.environment}"
  }
}

# Get us the newest base ami to update our launch configurations
data "aws_ami" "bastion" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "owner-id"
    values = ["137112412989"]
  }
}

module "bastion" {
  source                = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"

  instance_type         = "t2.micro"
  ami                   = "${data.aws_ami.bastion.id}"
  iam_instance_profile  = "${module.iam.profile_name}"
  s3_bucket_name        = "${aws_s3_bucket.ssh.id}"
  vpc_id                = "${var.vpc_id}"
  subnet_ids            = ["${var.subnet_ids}"]
  keys_update_frequency = "${var.cron_update_frequency}"
}
