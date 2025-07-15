# ☁️ AWS Terraform EC2 & S3 Setup Guide
This project demonstrates how to provision an EC2 instance and optionally create an S3 bucket using Terraform on AWS.

## 🔧 INSTALL

1. Download and install Terraform:  
   https://developer.hashicorp.com/terraform/install#windows  
   Add Terraform to your system PATH.

2. Download and install AWS CLI v2:  
   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html  

3. Verify installations:  
   ```bash
   aws --version
   terraform -v
## 🔧 CONFIGURE
1. **Create an IAM user** with Programmatic access in AWS Console.

<img width="1347" height="803" alt="image" src="https://github.com/user-attachments/assets/e9b5e86f-d8e6-4aef-af7e-cae3eb248dba" />


2. You cam attach **directly** at least these policies to the user:

AmazonEC2FullAccess

AmazonVPCFullAccess

IAMReadOnlyAccess

Optionally, AmazonS3FullAccess (if working with S3)

3. **Generate Access Key and Secret Key for the user.**

4. **Configure AWS CLI with your keys**
Enter Access Key ID, Secret Access Key, default region (e.g., eu-central-1), and output format (json).

    ```bash
    aws configure

  ```bash
  output:
  
  svist000@LAPTOP MINGW64 /c/github/cloud/terraform
  
  $ aws configure
  
  AWS Access Key ID [****************AUOE]:
  
  AWS Secret Access Key [****************1rS+]:
  
  Default region name [eu-central-1]:
  
  Default output format [json]:
```

5. **Test credentials**
```bash
aws sts get-caller-identity
```
