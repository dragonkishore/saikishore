# data "aws_ami" "amazon_linux_ecs" {
#   most_recent = true

#   owners = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["ami-odbd*cf71"]
#   }

#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }
# }
variable "asgname" {}
variable "asg_security_groups" {}
variable "tagname" {}
variable "asg_vpc_zone_identifier" {}