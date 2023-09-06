package graphql

import (
	"bytes"
	"encoding/json"
	"io"
	"log"
	"net/http"
	"os"
)

type QueryRequestBody struct {
	Query     string `json:"query"`
	Variables string `json:"variables"`
}

func CallGraphQL(query string, variables string) string {
	if variables == "" {
		variables = "{}"
	}
	const api_endpoint = "https://api.github.com/graphql"

	token := os.Getenv("GH_TOKEN")
	header := http.Header{}
	header.Set("Authorization", "Bearer "+token)
	header.Set("Accept", "application/json")
	var query_body QueryRequestBody
	query_body = QueryRequestBody{query, variables}
	// init http request
	json_body, _ := json.Marshal(query_body)
	req, err := http.NewRequest("POST", api_endpoint, bytes.NewReader(json_body))
	if err != nil {
		log.Fatalf("Error")
	}
	req.Header = header
	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		log.Fatalf("Error")
	}
	defer res.Body.Close()
	// read response body
	read_bytes, _ := io.ReadAll(res.Body)
	var buf bytes.Buffer
	err = json.Indent(&buf, read_bytes, "", "  ")
	return buf.String()
}
