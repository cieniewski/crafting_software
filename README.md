# JobProcessor

## Notes
- Went with simple application without phoenix to reduce the amount of boilerplate.
- Sorting approach does not handle cyclic dependencies.

## Setup
- Run `mix deps.get` to install the dependencies.

## Running the application
- Run `mix run --no-halt` to start the application.

## Running the tests
- Run `mix test` to run the tests.

## Example usage
- The application listens on port 4000.

### Sample request with shell script response:
```shell
curl --location 'localhost:4000/jobs' \
--header 'Accept: text/x-shellscript' \
--header 'Content-Type: application/json' \
--data '{
    "tasks": [
        {
            "name": "task-1",
            "command": "touch /tmp/file1"
        },
        {
            "name": "task-2",
            "command": "cat /tmp/file1",
            "requires": [
                "task-3"
            ]
        },
        {
            "name": "task-3",
            "command": "echo '\''Hello World!'\'' > /tmp/file1",
            "requires": [
                "task-1"
            ]
        },
        {
            "name": "task-4",
            "command": "rm /tmp/file1",
            "requires": [
                "task-2",
                "task-3"
            ]
        }
    ]
}'
```

### Sample request with json response(default):
```shell
curl --location 'localhost:4000/jobs' \
--header 'Content-Type: application/json' \
--data '{
    "tasks": [
        {
            "name": "task-1",
            "command": "touch /tmp/file1"
        },
        {
            "name": "task-2",
            "command": "cat /tmp/file1",
            "requires": [
                "task-3"
            ]
        },
        {
            "name": "task-3",
            "command": "echo '\''Hello World!'\'' > /tmp/file1",
            "requires": [
                "task-1"
            ]
        },
        {
            "name": "task-4",
            "command": "rm /tmp/file1",
            "requires": [
                "task-2",
                "task-3"
            ]
        }
    ]
}'
```

