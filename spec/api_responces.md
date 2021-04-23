POST https://safe-for-work-api.herokuapp.com/api/analyses
JSON: 
{
  "analysis": {
    "resource": "https://empire-s3-production.bobvila.com/articles/wp-content/uploads/2020/06/Types-of-Palm-Trees.jpg", 
    "category": "image"
  }
}
ANSWER:
{
    "id": 36,
    "category": "image",
    "resource": "https://empire-s3-production.bobvila.com/articles/wp-content/uploads/2020/06/Types-of-Palm-Trees.jpg",
    "results": {
        "safe": "0.99679315",
        "suggestive": "0.0022123302",
        "drug": "0.00091581425",
        "explicit": "7.84116e-05",
        "gore": "2.5105382e-07"
    },
    "request_ip": "213.80.123.2",
    "created_at": "2021-04-21T10:49:23.834Z",
    "updated_at": "2021-04-21T10:49:23.834Z"
}


POST https://safe-for-work-api.herokuapp.com/api/analyses
JSON:
{
  "analysis": {
    "resource": "Have a nice day kind sir",
    "category": "text"
  }
}
ANSWER:
{
    "id": 41,
    "category": "text",
    "resource": "Have a nice day kind sir",
    "results": {
        "text": "Have a nice day kind sir",
        "external_id": null,
        "error": "false",
        "classifications": "[{\"tag_name\"=>\"clean\", \"tag_id\"=>57725628, \"confidence\"=>0.97}]"
    },
    "request_ip": "213.80.123.2",
    "created_at": "2021-04-21T10:55:51.594Z",
    "updated_at": "2021-04-21T10:55:51.594Z"
}