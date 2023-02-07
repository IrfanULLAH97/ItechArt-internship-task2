# ItechArt-internship-task2
* Create two EC2 in the AWS using Terraform
* Install the Nginx on the created EC2 Instances
* Replace the default nginx-website with the new-website
* Add the Load balancer in front of the created EC2 Instances



### To execute the codey use below given terraform commands:
```
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply --auto-approve
```

### then to destroy the created resources use below command:
```
terraform destroy --auto-approve
