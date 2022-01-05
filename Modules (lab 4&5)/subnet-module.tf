module "Ahmed-subnet-module" {
  source         = "./Subnet"
  private-subnet = ["10.0.4.0/24", "10.0.3.0/24", "10.0.2.0/24", "10.0.1.0/24"]
  vpc-id         = module.Ahmed-VPC-module.vpc-id-output

}