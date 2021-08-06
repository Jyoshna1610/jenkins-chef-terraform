resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-0b37ee9a54bce1416"]
   key_name               = "terra-chef-jen"
   
   
provisioner "remote-exec" {
    inline = [    
       "wget -O /tmp/chef.rpm https://packages.chef.io/files/stable/chef-workstation/20.7.96/el/7/chef-workstation-20.7.96-1.el7.x86_64.rpm", #Installing chef workstation
      "sudo rpm -Uvh /tmp/chef.rpm",      
       "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 15.8.23", #Installing Chef client
       "chef-client -v",
       "which chef",
       "sudo yum update -y",
       "sudo yum install git -y",
       "git version",       
       "mkdir mygit",
       "cd mygit",
       "git clone https://github.com/Abishek-Ravichander/Stater_Kit.git",
       "cd Stater_Kit",
       "unzip chef-starter", 
       "mv apache-cookbook chef-repo",
       "cd chef-repo",
       "mv apache-cookbook cookbooks",
       "cd cookbooks",
       #" printf 'yes\n' | chef exec ruby -c apache-cookbook/recipes/apache-recipe.rb",              
       #"sudo chef-client -zr \"recipe[apache-cookbook::apache-recipe]\"",
       "knife bootstrap 172.31.45.126 --ssh-user ec2-user --sudo -i terra-chef-jen.pem -N chefnode1",
    ]
      
      connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    private_key = file("${path.module}/terra-chef-jen.pem")
    host = self.public_ip
  }
  }
      
 }

