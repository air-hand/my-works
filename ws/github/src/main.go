package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/google/go-github/v54/github"

	"github.com/kr/pretty"
)

func main() {
	ctx := context.Background()
	client := github.NewTokenClient(ctx, os.Getenv("GH_TOKEN"))
	// pass an empty string to list authenticated user's repositories
	repos, _, err := client.Repositories.List(ctx, "", nil)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%# v", pretty.Formatter(repos))
}
