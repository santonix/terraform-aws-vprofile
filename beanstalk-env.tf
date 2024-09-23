resource "aws_elastic_beanstalk_environment" "vprofile-beanstalk-prod" {
    name = "vprofile-beanstalk-prod"
    application = aws_elastic_beanstalk_application.vprofile-prod.name
    solution_stack_name = "64bit Amazon Linux 2 v4.3.15 running Tomcat 8.5 Corretto 11"
    setting {
      name = "vpcid"
      namespace = "aws:ec2:vpc"
      value = module.vpc.vpc_id
    }
    setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name = "IamInstanceProfile"
      value = "aws-elasticbeanstalk-ec2-role"
    }
    setting {
      namespace = "aws:ec2:vpc"
      name = "AssociatePublicIpAddress"
      value = "false"
    }
    setting {
      namespace = "aws:ec2:vpc"
      name = "subnets"
      value = join(",", [module.vpc.private_subnets[0],module.vpc.private_subnets[1], module.vpc.private_subnets[2] ])
    }
    setting {
      namespace = "aws:ec2:vpc"
      name = "ELBsubnets"
      value = join(",", [module.vpc.private_subnets[0],module.vpc.private_subnets[1], module.vpc.private_subnets[2] ])
    }
    
    setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name = "EC2KeyName"
      value = "aws_key_pair.vprofilekey.key_name"
    }
    setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name = "InstanceType"
      value = "t2.micro"
    }
    setting {
      namespace = "aws:autoscaling:asg"
      name = "Availability zones"
      value = "Any 3"
    }  
    setting {
      namespace = "aws:autoscaling:asg"
      name = "MinSize"
      value = "1"
    }
     setting {
      namespace = "aws:autoscaling:asg"
      name = "MaxSize"
      value = "8"
    }
    setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name = "environment"
      value = "prod"
    }
    setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name = "LOGGING_APPENDER"
      value = "GRAYLOG"

    }
    setting {
        namespace = "aws:elasticbeanstalk:healthreporting:system"
        name = "SystemType"
        value = "enhanced"
    }

    setting {
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      name = "RollingUpdateEnabled"
      value = "true"
    }
    setting {
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      name = "RollingUpdateType"
      value = "Health"
    }
    setting {
      namespace = "aws:autoscaling:updatepolicy:rollingupdate"
      name = "MaxBatchSize"
      value = "1"
    }
    setting {
      namespace = "aws:elb:loadbalancer"
      name = "CrossZone"
      value = "true"

    }
    setting {
      namespace = "aws:elasticbeanstalk:command"
      name = "BatchSizeType"
      value = "fixed"
    }
    setting {
      name = "StickinessEnabled"
      namespace = "aws:elasticbeanstalk:environment:process:default"
      value = "true"
    }

    setting {
      namespace = "aws:elasticbeanstalk:command"
      name = "BatchSize"
      value = "1"
    }

    setting {
      namespace = "aws:elasticbeanstalk:command"
      name = "DeploymentPolicy"
      value = "Rolling"
    }

    setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name = "SecurityGroups"
      value = "aws_security_group.vprofile-prod-sg.id"
    }

    setting {
      namespace = "aws:elbv2:loadbalancer"
      name = "SecuriyGroups"
      value = "aws_security_group.vprofile-bean-elb-sg"
    }

    depends_on = [ aws_security_group.vprofile-bean-elb-sg, aws_security_group.vprofile-prod-sg ]
}
