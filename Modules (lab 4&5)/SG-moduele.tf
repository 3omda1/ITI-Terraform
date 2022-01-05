module "Ahmed-SG-module" {
  source = "./Security group"
  vpc-id = module.Ahmed-VPC-module.vpc-id-output

}