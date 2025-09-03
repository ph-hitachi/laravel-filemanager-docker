# Base image with PHP 8.2 + Apache
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    zip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create the necessary directories if they do not exist

WORKDIR /var/www/html

# Install fresh Laravel 12 project in 'html' directory
RUN composer create-project laravel/laravel:^12.0 ./

# Set working directory inside Laravel app
RUN ls -la

RUN pwd

# Install Laravel Filemanager
RUN composer require unisharp/laravel-filemanager

# Publish Filemanager assets
RUN php artisan vendor:publish --tag=lfm_config \
    && php artisan vendor:publish --tag=lfm_public

# Patch routes/web.php automatically
RUN echo "<?php\n\
use Illuminate\\Support\\Facades\\Route;\n\
\n\
Route::get('/', function () {\n\
    return redirect()->route('unisharp.lfm.show');\n\
});\n\
\n\
Route::group(['prefix' => 'laravel-filemanager', 'middleware' => ['web']], function () {\n\
    \UniSharp\\LaravelFilemanager\\Lfm::routes();\n\
});" > routes/web.php

# Fix permissions for storage, bootstrap/cache, and public
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public /var/www/html/database
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public /var/www/html/database

# Copy custom Apache config
COPY vhost.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
