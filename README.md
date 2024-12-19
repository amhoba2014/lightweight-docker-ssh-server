# Simple SSH Server in Docker

This repository provides a Docker image for a simple SSH server based on Alpine Linux. The server allows users to connect via SSH with a specified username and password. This setup is ideal for development and testing purposes.

## Features

- Lightweight base image using Alpine Linux.
- Supports user-defined usernames and passwords.
- Allows SSH access with password authentication.
- Automatically displays the container's IP address upon startup.
- Simple to build and run with Docker.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your machine.
- Basic knowledge of Docker commands.

### Building the Docker Image

To build the Docker image, clone this repository and navigate to its directory:

```bash
git clone https://github.com/amhoba2014/lightweight-docker-ssh-server
cd lightweight-docker-ssh-server
```

Then, build the image using the following command. You can specify a custom username and password using build arguments:

```bash
docker build --build-arg USERNAME=myuser --build-arg PASSWORD=mypassword -t ssh-server .
```

If you want to use the default username (`user`) and password (`user`), simply run:

```bash
docker build -t ssh-server .
```

### Running the Docker Container

To run the container, use the following command:

```bash
docker run --rm -it -p 2222:22 ssh-server
```

This command will start the SSH server and map port 2222 on your host to port 22 in the container.

### Connecting to the SSH Server

Once the container is running, you will see output similar to:

```
SSH server is starting. Container IP address: <container_ip>
You can now connect using ssh user@<container_ip> with password: user
```

To connect to the SSH server, use an SSH client (like OpenSSH) from your terminal:

```bash
ssh user@<container_ip> -p 2222
```

You will be prompted to enter the password. Use the password you specified during the build process or the default password (`user`).

## Security Considerations

This SSH server configuration is intended for development and testing purposes only. It is not secure for production environments due to:

- Password authentication being enabled.
- Root login being disabled (though root access may still be possible through other means).

For production use, consider implementing key-based authentication and further hardening your SSH server configuration.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have suggestions or improvements.

## Acknowledgements

- [Alpine Linux](https://alpinelinux.org/) for providing a lightweight base image.
- [OpenSSH](https://www.openssh.com/) for secure shell access.

---

Feel free to modify this README as needed, especially sections like "License" or "Contributing" based on your project's specifics. Happy coding!
