variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "MyEC2Instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the existing EC2 Key Pair to enable SSH access"
  type        = string
}

# variable "allowed_ssh_cidr" {
#   description = "CIDR block to allow SSH access (e.g., your IP address in CIDR format)"
#   type        = list(string)
#   default     = ["0.0.0.0/0"]
# }

# variable "additional_ingress_ports" {
#   description = "Extra ports to allow inbound traffic (e.g., [80, 443, 8080])"
#   type        = map(string)
#   default     = {}
# }

variable "public_subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}
