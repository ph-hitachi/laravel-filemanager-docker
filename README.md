# Laravel FileManager Docker Setup

This project sets up a Laravel application with **Laravel 12** with **Unisharp Laravel FileManager** `^2.11` using **Docker**.

## Installation

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/ph-hitachi/laravel-filemanager-docker.git
cd laravel-filemanager-docker
```

### 2. Build and Start Docker Containers

Run the following command to build and start the Docker containers:

```sh
docker-compose up --build -d
```

### 3. Access the Application

Once the containers are up and running, access your Laravel application at::

[http://localhost:8000](http://localhost:8000)


### 4. Access the Docker Container

To access the running Docker container, use the following command:

```sh
docker exec -it laravel-filemanager bash
```

### Credits
- Laravel: [Laravel Framework](https://github.com/laravel/laravel)
- Laravel FileManager: [Unisharp Laravel FileManager](https://github.com/UniSharp/laravel-filemanager)