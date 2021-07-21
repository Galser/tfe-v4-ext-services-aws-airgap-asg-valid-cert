module "kt_test" {
  source = "../../.."
	# We are NOT PROVIDING VALUE for test_var
}

output "hello" {
  value = module.kt_test.hello
}
