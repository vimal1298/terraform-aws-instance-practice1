resource "aws_instance" "ec2_creation" {  

  ami           = var.ami  

  instance_type = var.instance_type  #"t2.micro"

  availability_zone = var.availability_zone

  subnet_id = var.subnet_id_pub

  tags = {

    Name = "WebServer-1"

 }

 provisioner "remote-exec" {

    inline = [

      "sudo useradd harry_potter"

    ]



    connection {

      type        = "ssh"

      user        = "ubuntu"

      private_key = "${file("keypair1.pem")}"

    }

  }

}



output "public-ip" {

  value = aws_instance.ec2_creation.public_ip

}



 provisioner "local-exec" {

        command =  "echo ${aws_subnet.subnet_public.id} ,${vpc_id.vpc.id}, ${aws_instance.web.id} > allids.txt"

  }
