﻿# Pooja-VPC-Terraform
 resource "aws_vpc" "myVPC" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "PoojaVPC"
    }
  
}

resource "aws_internet_gateway" "myIGW" {
vpc_id = aws_vpc.myVPC.id
tags = {
        Name = "MyInternetGateway"
    }
}

resource "aws_subnet" "public_subnet_1" {
vpc_id = aws_vpc.myVPC.id
cidr_block = "192.168.1.0/24"
availability_zone = "ap-south-1a"
tags = {
    Name = "PublicSubnet_1"
}
}

resource "aws_subnet" "public_subnet_2" {
vpc_id = aws_vpc.myVPC.id
cidr_block = "192.168.2.0/24"
availability_zone = "ap-south-1b"
tags = {
    Name = "PublicSubnet_2"
}
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.myVPC.id
    cidr_block = "192.168.5.0/24"
    availability_zone = "ap-south-1a" 
    tags = {
        Name = "PrivateSubnet_1"
    }
}
resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.myVPC.id
    cidr_block = "192.168.6.0/24"
    availability_zone = "ap-south-1b" 
    tags = {
        Name = "PrivateSubnet_2"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.myVPC.id
    tags = {
        Name = "PublicRouteTable"
    }
  
}

resource "aws_route" "public_internet_gateway" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
  
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.myVPC.id
    tags = {
        Name = "PrivateRouteTable"
    }
  
}

resource "aws_route_table_association" "public_route_table_association_1" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
  
}
    
resource "aws_route_table_association" "public_route_table_association_2" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association_1" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "sg" {
    name = "MySecurityGroup"
    vpc_id = aws_vpc.myVPC.id
    tags = {
        Name = "MySecurityGroup"
    }  
}
