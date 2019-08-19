# Shorty

**Shortens url**

## Requirements
- elixir 1.9

## Running
`mix run --no-halt`

## Usage
```
curl -H 'Content-Type:application/json' localhost:4040/urlx -d '{"url": "google.com"}'
```

```
curl localhost:4040/urlx/some_id
```
