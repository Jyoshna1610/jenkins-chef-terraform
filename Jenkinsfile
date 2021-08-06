pipeline {

environment {
        AWS_ACCESS_KEY_ID = credentials('AWS-ACCESS-KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS-SECRET-KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
        stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/Jyoshna1610/jenkins-chef-terraform.git"
                        
                    }
                }
            }
        stage('AWS Connection Check') {
            steps {
                        sh '''
                        aws --version
                        aws ec2 describe-instances
                        '''
                }
            }
        
        stage('Plan') {
            steps {
                bat 'cd&cd terraform/Terraform-Chef & terraform init -input=false'
                bat 'cd&cd terraform/Terraform-Chef & terraform workspace new $terrachef1'
                bat 'cd&cd terraform/Terraform-Chef & terraform workspace select $terrachef1'
                bat "cd&cd terraform/Terraform-Chef & terraform plan -input=false -out tfplan "
                bat 'cd&cd terraform/Terraform-Chef & terraform show -no-color tfplan > tfplan.txt'
            }
        }
       

        stage('Apply') {
            steps {
                bat "cd&cd terraform/Terraform-Chef & terraform apply -input=false tfplan"
            }
        }
        
        }
   }

