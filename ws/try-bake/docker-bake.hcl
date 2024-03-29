variable "UID" {}
variable "GID" {}
variable "USERNAME" {}
variable "HOMEDIR" {}
variable "PROJECT_NAME" {}
variable "DOCKER_GID" {}

group "default" {
    targets = ["dev"]
}

target "common" {
    platforms = ["linux/amd64"]
}

target "base" {
    context = "../../"
    dockerfile = "base-tools/Dockerfile.base"
    args = {
        UID = "${UID}"
        GID = "${GID}"
        USERNAME = "${USERNAME}"
        HOMEDIR = "${HOMEDIR}"
        DOCKER_GID = "${DOCKER_GID}"
    }
    inherits = ["common"]
}

target "dev" {
    context = "."
    dockerfile = "./Dockerfile"
    contexts = {
        # target:base イメージを元に構築できる
        base-image = "target:base"
    }
    inherits = ["common"]
    tags = ["${PROJECT_NAME}:latest"]
}
