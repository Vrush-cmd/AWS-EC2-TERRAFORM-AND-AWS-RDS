resource "aws_instance" "wp" {
    ami = "ami-041db4a969fe3eb68"
    key_name = "task3" 
    instance_type = "t2.micro"
    security_groups = [ "launch-wizard-1" ]


    tags = {
        Name = "Wordpress_db_task3"
          }
}


resource "null_resource" "task3" {
    connection {
      type = "ssh"
      user="ec2-user"
      private_key =  file("C:/Users/User/Downloads/task3.pem")
      host = aws_instance.wp.public_ip
    }
provisioner "remote-exec" {
    inline = [
        "sudo yum install httpd -y",
        "sudo yum install php -y" ,
        "sudo systemctl start httpd",
        "sudo systemctl start php" ,
        "cd /var/www/html" ,
        "sudo wget https://wordpress.org/latest.zip",
        "sudo unzip latest.zip"
    ]
  
}
  
}



output "wp_public_ip" {
    value = aws_instance.wp.public_ip
}