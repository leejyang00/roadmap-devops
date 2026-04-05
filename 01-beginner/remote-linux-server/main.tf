
# Defining the VPC module
module "vpc" {
  source = "./modules/vpc"
}

# Defining the EC2 instance module
module "ec2_instance" {
  source = "./modules/ec2-instance"

  # variables
  instance_name    = "EC2-instance-remote-linux"
  instance_type    = "t3.micro"
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id           = module.vpc.vpc_id
  key_name         = "kp-remote-linux"  # replace with your actual key pair name
}