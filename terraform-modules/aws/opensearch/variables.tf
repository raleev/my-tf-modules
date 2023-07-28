variable "domain_name" {
  type        = string
  default     = ""
  description = "(Optional) The friendly name for the Open Search Domain. By default generated by Terraform."
}

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "The AWS region"
}

variable "account_id" {
  type        = string
  default     = null
  description = "The account_id of your AWS Account. This allows sure the use of the account number in the role to mitigate issue of aws_caller_id showing *** by obtaining the value of account_id "
}

variable "enforce_https" {
  type        = bool
  default     = true
  description = "Whether or not to require HTTPS. Defaults to true"
}

variable "vpc_enabled" {
  type        = bool
  description = "enable vpc based open search, the dynamic block creates a vpc_options block with the specified security group and subnet IDs. If the variable is set to false, the dynamic block is not created, and the aws_opensearch_domain resource will not include a vpc_options block, creating the OpenSearch domain publicly."
  default     = true
}

variable "zone_awareness_enabled" {
  type        = bool
  description = "By Default 2 availability zones"
  default     = true
}

variable "ebs_enabled" {
  type        = bool
  description = "Ebs Storage enabled or disabled"
  default     = true
}

variable "volume_size" {
  type        = number
  default     = 10
  description = "Size of EBS volumes attached to data nodes (in GiB)"
}

variable "retention_in_days" {
  type        = number
  default     = 14
  description = "Specifies the number of days you want to retain log events in the specified log group"
}

variable "tags" {
  type        = any
  default     = {}
  description = "AWS Tags"
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "(Required) The private subnet IDs in which the environment should be created."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The vpc ID"
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "Number of instances in the cluster"
}

variable "instance_type" {
  type        = string
  default     = "r4.large.search"
  description = "Instance type of data nodes in the cluster."
}

variable "tls_security_policy" {
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
  description = "HTTPS enforced with TLS security policy"
}

variable "additional_security_group_ids" {
  type        = list(string)
  default     = []
  description = "Additional security group IDs to be attached to the OpenSearch domain."
}

variable "allowed_roles" {
  type        = string
  description = "A list of AWS role ARNs allowed to access the OpenSearch domain"
  default     = "*"
}

variable "ingress_rule" {
  type        = list(any)
  description = "A list of ingress rules"
  default = [
    {
      description = "TLS from VPC"
      //Port 443 is commonly used port for secure HTTPS traffic
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
      ipv6_cidr_blocks = []
    },
  ]
}

variable "egress_rule" {
  type        = list(any)
  description = "A list of egress rules"
  default = [
    {
      description = "Allow outbound HTTPS traffic to VPC"
      //Port 443 is commonly used port for secure HTTPS traffic
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
      ipv6_cidr_blocks = ["::/0"]
    },
  ]
}
