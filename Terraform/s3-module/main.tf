module "s3" {
    source = "./s3"  
    region = var.region
    bucket-s3 = var.bucket-s3
}
output "s3-id" {
    value = "module.s3.bucket_id"
  
}