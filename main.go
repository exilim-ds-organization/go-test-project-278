package main

import (
	"log"
	"time"

	"github.com/getsentry/sentry-go"
	sentrygin "github.com/getsentry/sentry-go/gin"
	"github.com/gin-gonic/gin"
)

func setupRouter() *gin.Engine {

	// создаём маршрутизатор Gin
	router := gin.Default()
	// Once it's done, you can attach the handler as one of your middleware
	router.Use(sentrygin.New(sentrygin.Options{}))
	// подключаем инструмент восстановления сбоев
	router.Use(gin.Recovery())
	// подулючаем логгер
	router.Use(gin.Logger())
	// создаём точку входа
	router.GET("/ping", func(c *gin.Context) {
		c.String(200, "pong")
	})
	return router
}

func main() {
	err := sentry.Init(sentry.ClientOptions{
		Dsn:            "https://b81aac0d2c97f7e747a4fb8aeb0d72ea@o4511376473587712.ingest.de.sentry.io/4511376481189968",
		Debug:          true,
		SendDefaultPII: true,
	})
	if err != nil {
		log.Fatalf("sentry.Init: %s", err)
	}
	defer sentry.Flush(2 * time.Second)
	router := setupRouter()
	// запускаем сервер на порту 8080
	router.Run(":8080")
}
