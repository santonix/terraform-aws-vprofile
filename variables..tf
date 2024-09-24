variable "aws_region" {

  default = "us-east-2"
}


variable "AMIS" {
  
  type = map
  default = {
    us-east-2 = "ami-085f9c64a9b75eed5"
    us-east-1 = ""

    ap-south-1 = ""
  }
}


variable "PRIVATE_KEY_PATH" {
  default = "/home/bonny/Downloads/vprofilekey.pem"
}


variable "PUBBLIC_KEY_PATH" {
  default = "/home/bonny/.ssh/id_rsa.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "158.47.217.60/32"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "Gr33n@pple123456"

}





variable "dbuser" {
    default = "admin"

}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "vpc_name" {
  default = "vprofile-vpc"
}

variable "zone1" {
  default = "us-east-2a"
}

variable "zone2" {
  default = "us-east-2b"
}
variable "zone3" {
  default = "us-east-2c"
}

variable "vpc_cidr_block" {
  default = "172.21.0.0/16"
}

variable "public_subnet1_cidr_block" {
  default = "172.21.1.0/24"
}

variable "public_subnet2_cidr_block" {
  default = "172.21.2.0/24"
}


variable "public_subnet3_cidr_block" {
  default = "172.21.3.0/24"
}

variable "private_subnet1_cidr_block" {
  default = "172.21.4.0/24"
}


variable "private_subnet2_cidr_block" {
  default = "172.21.5.0/24"
}

variable "private_subnet3_cidr_block" {
  default = "172.21.6.0/24"
}



