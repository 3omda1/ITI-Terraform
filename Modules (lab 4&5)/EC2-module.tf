
module "Ahmed-EC2-module" {
  source             = "./EC2"
  ami-name           = "ami-04dd4500af104442f"
  instance-type-name = "t2.micro"
  subnet-id          = module.Ahmed-subnet-module.subnet-id-output

}

