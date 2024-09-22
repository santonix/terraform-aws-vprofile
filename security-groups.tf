resource "aws_security_group" "vprofile-bean-elb-sg"{
    name = "vprofile-bean-elb-sg"
    description = "security group for bean-elb"
    vpc_id = module.vpc.vpc_id

    ingress =  [ 
      {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
        description      = "Allow all inbound traffic on port 80"
      }
    ]  

    egress = [
      {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
        description      = "Allow all outbound traffic"
      }  
            
    ]  

}

resource "aws_security_group" "vprofile-bastion-sg" {

    name = "vprofile-bastion-sg"  
    description = "security group for bastion host ec2 instance"
    vpc_id = module.vpc.vpc_id

    egress = [
      {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
        description      = "Allow all outbound traffic"
      }
    ]  

    ingress = [
    
      {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.MYIP]
        ipv6_cidr_blocks = []       # Empty list for IPv6 CIDR blocks
        prefix_list_ids  = []       # Empty list for prefix list IDs
        security_groups  = []       # Empty list for security groups
        self             = false    # Whether this security group itself is included
        description      = "Allow SSH from my IP"  # Optional descri
      }
    ]  

}

resource "aws_security_group" "vprofile-prod-sg" {
    name = "vprofile-prod-sg"
    description = "sg for beanstalk instances"
    vpc_id = module.vpc.vpc_id

    egress = [
      {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        cidr_blocks = [var.MYIP]
        ipv6_cidr_blocks = []       # Empty list for IPv6 CIDR blocks
        prefix_list_ids  = []       # Empty list for prefix list IDs
        security_groups  = []       # Empty list for security groups
        self             = false    # Whether this security group itself is included
        description      = "Allow SSH outbound traffic"  # Optional descri
      }
    ]
    ingress = [
      {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.vprofile-bastion-sg.id]
        cidr_blocks = [var.MYIP]
        ipv6_cidr_blocks = []       # Empty list for IPv6 CIDR blocks
        prefix_list_ids  = []       # Empty list for prefix list IDs
        security_groups  = []       # Empty list for security groups
        self             = false    # Whether this security group itself is included
        description      = "Allow SSH from bastion"  # Optional descri
      }
    ]  
}

resource "aws_security_group" "vprofile-backend-sg" {
    name = "vprofile-backend-sg"
    description = "sg for RDS, active mq, elastic cached"
    vpc_id = module.vpc.vpc_id

    egress = [
      {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        cidr_blocks = [var.MYIP]
        ipv6_cidr_blocks = []       # Empty list for IPv6 CIDR blocks
        prefix_list_ids  = []       # Empty list for prefix list IDs
        security_groups  = []       # Empty list for security groups
        self             = false    # Whether this security group itself is included
        description      = "Allow outbound traffic"  # Optional descri
      }
    ]  

    ingress = [
      {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        security_groups = [aws_security_group.vprofile-prod-sg.id]
        cidr_blocks = [var.MYIP]
        ipv6_cidr_blocks = []       # Empty list for IPv6 CIDR blocks
        prefix_list_ids  = []       # Empty list for prefix list IDs
        security_groups  = []       # Empty list for security groups
        self             = false    # Whether this security group itself is included
        description      = "Allow inbound traffic"  # Optional descri
      }
    ]  
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    security_group_id = aws_security_group.vprofile-backend-sg.id
    source_security_group_id = aws_security_group.vprofile-backend-sg.id
}