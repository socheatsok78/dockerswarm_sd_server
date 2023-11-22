target "docker-metadata-action" {}
target "github-metadata-action" {}

target "default" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    context = "."
    dockerfile = "Dockerfile"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

target "dev" {
    context = "."
    dockerfile = "Dockerfile"
    tags = [
        "localhost/dockerswarm-sd-server:dev"
    ]
}
