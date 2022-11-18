# nuvei_task
Try to think “Big” and consider the following guidelines:
• Design and implement your solution as you would do in real production code.
• Documentation and maintainability
• Feel free to add any features you feel are appropriate! Really, we’re curious how your mind
works and we’d expect the same if you worked with us.

AWS Infrastructure as Code
Using Terraform, create the following resources:
• VPC with two public and private subnets
• Route Tables for each subnet
• Security Group to allow port 80 and 443 from the internet
• ELB – Listening on ports 80 & 443
• Public route53 hosted zone and CNAME entry for the ELB


AWS API
Create a script using any preferred programming language (preferably, PowerShell/Python) to perform
the following activities:
• List all AWS Resources being used in the account, per region
• List each resource in detail (EC2, RDS etc)