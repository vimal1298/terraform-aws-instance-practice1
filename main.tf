resource "aws_instance" "ec2_creation" {  

  ami           = var.ami  

  instance_type = var.instance_type  #"t2.micro"

  #availability_zone = var.availability_zone

  subnet_id = var.subnet_id_pub
  key_name = "keyname"

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

      private_key = "${file("keyname.pem")}"

    }

  }

}



output "public-ip" {

  value = aws_instance.ec2_creation.public_ip

}



 provisioner "local-exec" {

        command =  "echo ${aws_subnet.subnet_public.id} ,${vpc_id.vpc.id}, ${aws_instance.web.id} > allids.txt"

  }
module "vpc-practice1" {
  source  = "app.terraform.io/infosys-tfpractice1/vpc-practice1/aws"
  version = "1.0.0"
  # insert required variables here
  subnet_id_pub = aws_subnet.public.id
}
