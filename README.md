
# Project Description

3-Tier Azure Infrastructure Production Demo Project Using Terraform (Modular)
The infrastructure simulates real-world production environments, focusing on:

Infrastructure as Code (IaC) 

Change management and version control

Secure access and identity management

Remote state management and locking  (In this project used local state)

Network and resource security hardening

Cost optimisation strategies

The primary goal of this project is to design a secure, scalable, and cost-efficient Azure architecture, following cloud security best practices and Terraform modular standards suitable for enterprise environments.


# Azure Service Used In Terraform Modular
-- Network:

* Resource Group Defined
* Virtual Network 
* Subnet (web,app,bastion,internal load balancer,private endpoint)
* Network Security Group
* Network Security Group Rules
* Subnet-Network Security Group Associate
* Bastion
* Public IP (Bastion IP, Load Balancer IP)
* Private Endpoint



-- Vmss Web:
* Web Servers (VMs)
* Passwordless
* tls/ssh

-- Vmss App:
* App Server
* Passwordless
* tls/ssh

-- Database
* Azure SQL (MYSQL)
* Crendentials stored in the keyvault
* Private access


-- Load Balancer
* Public load balancer
* Internal load balancer


-- Security & Identity
* Azure Key vault
* Managed Identity
* RBAC

-- Monitoring & Log
* Log Analytics
* Diagnostic logs
* Alert  configure

# Terraform Configuration

* Provider block configuration
* Local state management
* Variables defined
* Sensitives marked
* Terraform format 
* Outputs

-- Testing
* Terraform validate


-- Deployment Steps

* Terraform init
* Terraform plan


# Architecture Design
![Architecture Diagram](https://github.com/Lola-source2/3-Tier-Azure-Infrastructure-Production-Demo-Project-Using-Terraform-Modular-/blob/master/3tier%20Application.drawio%20(1).png)


# Why Virtual Machine Scale Set
Although Virtual Machine Scale Sets (VMSS) are not always the cheapest compute option, they offer strong operational control, predictability, and enterprise-grade reliability, which are critical for production and regulated environments.

VMSS was chosen to provide a robust core infrastructure with the following capabilities:

-- Infrastructure control
Full control over operating system configuration, patching schedules, and system-level settings.

* Enterprise security and compliance
Supports strict security baselines, custom hardening, audit requirements, and regulatory compliance frameworks.

* Predictable performance
Dedicated VM resources ensure consistent performance, unlike some shared or abstracted platform services.

* Hybrid compatibility
Works well with hybrid architectures and legacy workloads that are not fully cloud-native.

-- Operational Advantages

VMSS enables:

Ownership of OS patching and update schedules

Installation of custom agents (security, monitoring, logging)

Enforcement of company-specific compliance and governance policies

These capabilities align well with enterprise operating models where infrastructure standardisation and auditability are mandatory.


# Why Not Cheaper Platform Services?

While managed services and PaaS offerings can deploy similar applications at a lower cost, they often limit:

OS-level control

Security customization

Compliance enforcement

Migration options for non-cloud-native applications

The key question is not only cost, but whether the infrastructure can be fine-tuned to meet security risk, compliance, and operational requirements.


# Migration Considerations

Not all applications are cloud-native. VMSS provides:

Easier migration paths for existing workloads

Compatibility with traditional application architectures

This makes VMSS a practical and lower-risk choice for organisations modernising existing systems while maintaining control.


# Project Operational Steps:

* Web Application (Frontend):
- Client sends request over the internet

- Request hits a Public Load Balancer

- Traffic is filtered by NSG rules on the web subnet

- Request is forwarded to Web VMSS instances

- Web tier can communicate with App tier using port (8080)

- Communication flows through a Private subnet/Internal Load Balancer

- Managed Identity is enable



* App Application (Backend):
- Traffic is filtered by NSG rules on the App subnet

- Request hits a Internal Load Balancer

- The App application is the brain of 3-tier application, this is where business logic take place. 

- App tier blocks direct internet access

- Managed Identity is enable

- App tier has outbound access only where required (e.g., Key Vault, Azure SQL private endpoint)

* Database (data layer):
- Azure SQL uses Private Endpoint

- No public network access

- App tier accesses secrets from Azure Key Vault

- Connection string credential details is retrieved securely from Azure Key Vault

# Admin Access
- IT admin login into Azure portal over Through port 443 tls/ssh to bastion public IP

- From Bastion, admin connects to VMSS Web / App using private IP and SSH.

- Using Bastion eliminates exposing VMs to the public internet

- This is private network access, no direct public IP is required

- Admins can perform maintenance (patching, monitoring, troubleshooting) securely.

# Monitoring 
- Diagnostic Setting targeted Vmss web and Vmss app, collecting logs and sending them to Log Analytics such as: Activity logs, metrics, application logs, and performance counters

- Logs → Diagnostic Setting → Log Analytics Workspace → Analysis / Alerts

- Helps with auditing, compliance, troubleshooting, and alerting



# Troubleshooting 

* Verify module source paths

- Ensure all source paths in the Terraform module blocks are correct and accessible.

* Check module calls in the root module


* Ensure sensitive outputs are marked properly

- Outputs containing secrets have sensitive = true to prevent exposing sensitive information in logs.

* Validate NSG rules

- Confirm that Network Security Group rules are correctly defined to allow required traffic while blocking unauthorized access.

# Project Achievements

Successfully designed and implemented a 3-tier Azure application using Terraform modular architecture, demonstrating industry-standard best practices.

- Designed a 3-tier architecture with Web VMSS, App VMSS, and Azure SQL Database.

- Applied Terraform modular principles, creating reusable and maintainable modules.

- Implemented enterprise-grade security and compliance, including NSGs, private endpoints, and secure secret management via Azure Key Vault.

- Gained hands-on experience in infrastructure provisioning, operational control, and monitoring in a cloud environment.

- Followed industry practices for IaC, scalability, and cost optimization.



