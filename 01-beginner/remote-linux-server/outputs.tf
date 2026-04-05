output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_instance_id" {
  value = module.ec2_instance.instance_id
}

output "ec2_instance_public_ip" {
  value = module.ec2_instance.public_ip
}