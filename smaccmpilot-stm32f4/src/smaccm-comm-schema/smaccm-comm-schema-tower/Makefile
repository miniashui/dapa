default:
	stack --stack-yaml stack.yaml build .

test:
	stack --stack-yaml stack.yaml test --test-arguments '--src-dir=codegen-out'
	make -C codegen-out