package main

import (
	"fmt"

	"app/graphql"
)

func main() {
	var res string
	res = graphql.CallGraphQL(`
query($number_of_repos:Int!) {
  viewer {
    name
     repositories(last: $number_of_repos) {
       nodes {
         name
       }
     }
   }
}`, `{
   "number_of_repos": 3
}`)
	res = graphql.CallGraphQL(`
query($number_of_repos:Int!) {
  viewer {
    name
     repositories(last: $number_of_repos) {
       nodes {
         name
         hasVulnerabilityAlertsEnabled
         languages(first: 10) {
            nodes {
                name
            }
         }
         defaultBranchRef {
            name
         }
         object(expression: "main:.github/workflows") {
            ... on Tree {
                entries {
                    path
                }
            }
         }
       }
     }
   }
}`, `{
   "number_of_repos": 3
}`)
	fmt.Printf("%s", res)
}
