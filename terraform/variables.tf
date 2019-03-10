variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-b"
}

variable "project_name" {
  description = "southern-ring-232616"
  default = "southern-ring-232616"
}

variable "credentials_file_path" {
  description = "/devops/homework2/keys/credential.json"
  default = "/devops/homework2/keys/credential.json"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default = "~/.ssh/gcloud_id_rsa.pub"
}
