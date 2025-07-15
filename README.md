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
## ⚙️ CONFIGURE
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
## 🪣 AWS S3 COMMON COMMANDS
List buckets:

```bash
aws s3 ls
```
Create bucket:

```bash
aws s3 mb s3://your-bucket-name
```
Delete bucket contents:

```bash
aws s3 rm s3://your-bucket-name --recursive
```
Delete bucket:

```bash
aws s3 rb s3://your-bucket-name
```
### 🛠️ TROUBLESHOOTING
If you get permission errors like:
AccessDenied when creating S3 buckets or IAM users, you need to update your IAM user's permissions.

For S3 bucket creation and management, you may need:

AdministratorAccess (for testing)

Or granular S3 permissions: s3:CreateBucket, s3:ListBucket, s3:GetObject, s3:PutObject, s3:DeleteObject

Test S3 permissions manually:

```bash
aws s3 mb s3://your-unique-bucket-name
```
To delete a bucket and its contents:

```bash
aws s3 rb s3://your-bucket-name --force
```
## 📄 Deploying Terraform Code
If you are usig VS Code, you can install Hashicorp Terraform extension

### 🔨 Basic Terraform commands:
Using this commands, you can deploy your template.

Initialize Terraform:

```bash
terraform init
```
Validate Terraform files syntax:

```bash
terraform validate
```
Preview changes Terraform will apply:

```bash
terraform plan
```
Deploy infrastructure:

```bash
terraform apply
```
Destroy infrastructure when no longer needed:

```bash
terraform destroy
```
### 🔐 SECURITY GROUPS & SSH ACCESS
By default, AWS EC2 instances do not have open inbound ports.

To connect via SSH (port 22):

Go to AWS Console → EC2 → Instances → Select your instance

Scroll to Security groups section → Click the linked security group

Edit Inbound rules → Add rule:

Type: SSH

Protocol: TCP

Port Range: 22

Source: your IP (CIDR format, e.g. 203.0.113.0/32) or anywhere (0.0.0.0/0 for testing)

Save and try SSH connection:

```bash
ssh -i /path/to/your/key.pem ubuntu@<instance_public_ip>
```
## 📚 Useful Links

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Official Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [AWS CLI Docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
