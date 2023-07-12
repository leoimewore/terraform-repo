//VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}


//Subnets 


data "aws_availability_zones" "available" {
  state = "available"
}

# output "azs" {
#   value =data.aws_availability_zones.available
# }

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet1CIDRblock
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
      Name = "Public"
    }
  
}


resource "aws_subnet" "Private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet2CIDRblock
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
      Name = "Private"
    }
  
}


resource "aws_internet_gateway" "Igw" {
  vpc_id =aws_vpc.main.id 

  tags = {
    Name="Igw"
  } 
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }

  tags = {
    Name = "PublicRT"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}



