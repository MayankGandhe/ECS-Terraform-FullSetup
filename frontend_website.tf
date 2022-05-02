module "frontend_website" {
  source             = "chgangaraju/cloudfront-s3-website/aws"
  version            = "1.2.2"
  domain_name        = "livefurnish-website-static-dev" // Any random identifier for s3 bucket name
  use_default_domain = true
  upload_sample_file = true
}