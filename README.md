# Design for Performance and Scalability

---

## Project  Instructions

In this project, we will plan, design, provision, and monitor infrastructure in AWS using industry-standard and open source tools. Optimize infrastructure for cost and performance. Using Terraform to provision and configure AWS services in a global configuration.

## Create AWS Architecture Schematics
Plan and provision a cost-effective AWS infrastructure for a new social media application development project for 50,000 single-region users:
[Udacity_Diagram_1.pdf](udacity-submission/Udacity_Diagram_1.pdf)

Plan a SERVERLESS architecture schematic for a new application development project:
[Udacity_Diagram_2.pdf](udacity-submission/Udacity_Diagram_2.pdf)

## Calculate Infrastructure Costs
1. Use the [AWS Pricing Calculator](https://calculator.aws/) to estimate how much it will cost to run the services in your Part 1 diagram for one month. Target a monthly estimate between $8,000-$10,000. [Initial_Cost_Estimate.csv](udacity-submission/Initial_Cost_Estimate.csv).

2. Return to the AWS Pricing Calculator and reconfigure your estimates for the following scenarios:

Your budget has been reduced from $8,000-$10,000 to a maximum of $6,500. What services will you modify to meet this new budget?
[Reduced_Cost_Estimate.csv](udacity-submission/Reduced_Cost_Estimate.csv)

3. Your budget has been increased to $20,000. What resources will you add and why?
Think about where to add redundancy and how to improve performance. Re-configure your estimate to a monthly invoice of $18K-20K.
[Increased_Cost_Estimate.csv](udacity-submission/Increased_Cost_Estimate.csv)

## Exercise 1
In the main.tf file write the code to provision:
 - AWS as the cloud provider
 - Use an existing VPC ID
 - Use an existing public subnet
 - 4 AWS t2.micro EC2 instances named Udacity T2
 - 2 m4.large EC2 instances named Udacity M4

### Exercise 2

1. In the  Exercise_2 folder, write the code to deploy an AWS Lambda Function using Terraform. Your code should include:

   * A lambda.py file
   * A main.tf file with AWS as the provider, and IAM role for Lambda, a VPC, and a public subnet
   * An outputs.tf file
   * A variables.tf file with an AWS region
