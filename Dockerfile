# PHP 8.0 CLI бейнесін негіз ретінде алыңыз
FROM php:8.0-cli

# Жүйені жаңарту және қажетті тәуелділіктерді орнату
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip

# Composer орнату
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Composer орнатылғанын тексеру
RUN composer --version

# Жұмыс каталогын орнату
WORKDIR /app

# Файлдарды контейнерге көшіру
COPY . .

# Laravel үшін рұқсаттарды орнату
RUN chmod -R 775 storage bootstrap/cache

# Composer тәуелділіктерін орнату (егжей-тегжейлі логтармен)
RUN composer install --no-dev --optimize-autoloader -vvv

# Laravel конфигурациясын кэштеу
RUN php artisan config:cache

# Портты ашу
EXPOSE 8000

# Laravel серверін іске қосу
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
