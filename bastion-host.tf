resource "aws_instance" "vprofile-bastion" {
    ami = lookup(var.AMIS,var.aws_region)
    instance_type = "t2.micro"
    key_name = aws_key_pair.vprofilekey.key_name
    subnet_id = module.vpc.public_subnets[0]
    count = var.instance_count
    vpc_security_group_ids = [aws_security_group.vprofile-bastion-sg.id]

    tags = {
      Name = "vprofile-bastion"
      project = "vprofile"
    }

    provisioner "file" {
        content = templatefile("/home/bonny/terraform-project/terraform-aws-vprofile/db-deploy.tmpl", {rds-endpoint = aws_db_instance.vprofile-rds.address, dbuser = var.dbuser})
        destination = "/tmp/vprofile-dbdeploy.sh"
      
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod +x /tmp/vprofile-dbdeploy.sh",
        "sudo /tmp/vprofile-dbdeploy.sh"
      ]
    }

    connection {
      user = var.USERNAME
      private_key = file(var.PRIVATE_KEY_PATH)
      host = self.public_ip
    }
    depends_on = [ aws_db_instance.vprofile-rds ]
  
}