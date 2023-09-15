import os
import json
import requests

API_ENDPOINT = 'https://api.github.com/graphql'

auth_token = os.environ.get('GH_TOKEN')

headers = {
    "Authorization": f"Bearer {auth_token}",
    "Accept": "application/json",
}


def do_query(cursor=None):
    query = """
query($bulk_size: Int!, $cursor: String) {
    viewer {
        repositories(first: $bulk_size, after: $cursor) {
            pageInfo {
                endCursor
                hasNextPage
            }
            nodes {
                name
            }
        }
    }
    rateLimit {
        limit
        cost
        remaining
        resetAt
    }
}
"""
    variables = {
        "bulk_size": 3,
        "cursor": cursor,
    }
    res = requests.post(API_ENDPOINT, json={'query': query, 'variables': variables}, headers=headers)
    j = res.json()
    print(json.dumps(j, indent=2))
    page_info = j['data']['viewer']['repositories']['pageInfo']
    if page_info['hasNextPage']:
        do_query(page_info['endCursor'])

do_query()
