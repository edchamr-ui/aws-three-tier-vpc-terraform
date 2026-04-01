# AWS High-Availability Three-Tier VPC Architecture

This project demonstrates professional-grade cloud infrastructure automation using **Terraform (Infrastructure as Code)**. 

## 🏗️ Architecture Overview
This deployment sets up a secure, scalable, and highly available network environment on AWS including:
- **Public Tier:** Internet Gateway and NAT Gateway for managed internet egress.
- **Application Tier:** Private subnets for application logic, isolated from direct internet access.
- **Data Tier:** Fully isolated private subnets for sensitive database workloads.

## 🚀 Key Features
- **High Availability:** Resources are distributed across multiple Availability Zones (AZs).
- **Security:** Implements a Bastion Host (Jump Server) architecture and fine-grained Security Groups.
- **Modular Design:** Uses dynamic CIDR calculations and variables for reusable deployments.

## 🛠️ Technologies Used
- **Cloud:** AWS (VPC, EC2, S3, IGW, NATGW)
- **IaC:** Terraform (HCL)
- **Security:** Network ACLs & Security Groups
