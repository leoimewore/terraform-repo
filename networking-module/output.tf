output "vpc-id" {

    value =aws_vpc.main.id
  
}

output "subnet-public" {
    value=aws_subnet.public.id
  
}

output "subnet-private" {
    value=aws_subnet.Private.id
  
}