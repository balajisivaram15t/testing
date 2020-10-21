###########################
# Variables
###########################
variable "resource_prefix" {
    type = string
    default = "aksdev"
}

variable "location" {
    type = string
    default = "East US2"
}

variable "resource_group_name" {
    type = string
    default = "AZ-RG-KubernetesCICD-Dev-01"
}

variable "tags" {
    type = map(string)

    default = {
        environment = "dev"
    }
}