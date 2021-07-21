variable "test_var" {
	# NO DEFAULT! 
	description = "Input to our module"
  type        = string
}

module "kt_test" {
  source = "../../.."
	test_var = var.test_var
}

output "hello" {
	description = "The value of output exposed from underlying module"
  value = module.kt_test.hello
}
