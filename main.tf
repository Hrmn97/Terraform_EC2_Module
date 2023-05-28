resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip
  availability_zone           = data.aws_availability_zone.az.id
  disable_api_termination     = var.disable_api_termination
  iam_instance_profile        = data.aws_iam_instance_profile.instance_profile.role_name
  key_name                    = data.aws_key_pair.key.key_name
  #   security_groups             = aws_security_group.allow_tls.id
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"] #data.aws_security_groups.sg.ids  
  subnet_id              = data.aws_subnet.selected.id

  user_data = file("${path.module}/file.sh")

  hibernation = false
  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.volume_size
    volume_type           = "standard"

    tags = {
      Name         = "ec2_production"
      application  = var.application
      organization = var.organization
    }
  }

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  tags = {
    Name         = "ec2_production"
    application  = var.application
    organization = var.organization
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = data.aws_availability_zone.az.id
  size              = 10
  snapshot_id       = null
  type              = "standard"

  tags = {
    Name         = "ebs_volume"
    application  = var.application
    organization = var.organization
  }
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.instance.id
}
