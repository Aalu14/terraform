
resource aws_key_pair my_key{
    key_name = "terraform-key"
    public_key = file("${path.module}/terraform-key.pub")
} 
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_instance" "terraform-instance" {
  ami                    = "ami-07f07a6e1060cd2a8" 
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.my_key.key_name  
  iam_instance_profile   = "ssm-management"    

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "terraform-ec2-instance"
  }
}
