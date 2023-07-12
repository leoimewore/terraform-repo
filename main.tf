# terraform {
#   required_providers {

#     aws = {
#     source="hashicorp/aws"

#     }

#   }
# }

# provider aws {}

# module "myvpc" {
# source ="./networking-module"  
# }


# resource "aws_instance" "myec2" {
#     ami = "ami-069d73f3235b535bd"
#     instance_type = "t2.micro"
#     subnet_id = module.myvpc.subnet-public
#     associate_public_ip_address = true
#     user_data = "${file("install_yum.sh")}"
#     vpc_security_group_ids = [aws_security_group.mysg.id]
#     tags = {
#         Name ="myec2"
#     }
  
# }

# resource "aws_security_group" "mysg" {
#   vpc_id = module.myvpc.vpc-id
#   name = "allowhttp"
#   ingress {
#     cidr_blocks = [ "0.0.0.0/0" ]
#     from_port = 80
#     protocol = "TCP"
#     to_port = 80
#   }
  

#   egress{
#     cidr_blocks = [ "0.0.0.0/0" ]
#     from_port = 0
#     to_port = 0
#     protocol = -1
#   }


#   tags = {
#     "Name" = "allow http"
#   }
# }


# resource "aws_lb" "test" {
#   name               = "test-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.mysg.id]
#   subnets = [module.myvpc.subnet-public,module.myvpc.subnet-private]
  

#   enable_deletion_protection = false
#   tags = {
#     Environment = "production"
#   }
# }

# resource "aws_lb_target_group" "test" {
#   name     = "tf-example-lb-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.myvpc.vpc-id
# }


# resource "aws_lb_target_group_attachment" "test1" {
#   target_group_arn = aws_lb_target_group.test.arn
#   target_id        = aws_instance.myec2.id
#   port             = 80
# }

# resource "aws_lb_listener" "front_end" {
#     load_balancer_arn = aws_lb.test.arn
#     port = "80"
#     protocol = "HTTP"

#     default_action {
#       type = "forward"
#       target_group_arn = aws_lb_target_group.test.arn
#     }
  
# }








