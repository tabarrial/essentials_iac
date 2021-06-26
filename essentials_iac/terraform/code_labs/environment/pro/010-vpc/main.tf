module "vpc" {
  source = "../../../modules/010-vpc"
  vpc_cidr = "10.0.0.0/16"
  subnet_vpc_cidr_1a = "10.0.4.0/22" //* 10.0.4.1 - 10.0.7.254 *//
  subnet_vpc_cidr_1b = "10.0.8.0/22" //* 10.0.8.1 - 10.0.11.254 *//
}
