lint: # проверка кода линтером golangci-lint
	golangci-lint run
	
test: # запуск тестов
	go test -v ./...
