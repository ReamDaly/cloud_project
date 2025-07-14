resource "aws_instance" "web_server" {
  ami           = "ami-0f3c7d07486cad139"  # Amazon Linux 2 in ap-southeast-1
  instance_type = "t2.micro"
  key_name      = "your-key-name"          # Replace with your key pair name
  subnet_id     = aws_subnet.main.id       # From your VPC
  security_groups = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>EC2 Web Server is Running</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "CloudProjectWebServer"
  }
}
