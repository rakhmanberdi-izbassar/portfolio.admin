# PHP 8.0 CLI бейнесін негіз ретінде алыңыз
FROM php:8.0-cli

# Қажетті тәуелділіктерді орнату
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_pgsql zip

# Composer орнату
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Composer орнатылғанын тексеру
RUN composer --version

# Жұмыс каталогын орнату
WORKDIR /app

# Файлдарды контейнерге көшіру
COPY . .

# Laravel үшін рұқсаттарды орнату
RUN chmod -R 775 storage bootstrap/cache

# `.env` файлын көшіріп, Laravel үшін конфигурация жасау
RUN cp .env.example .env

# 📌 **Composer install (ЕҢ БАСТЫ ҚАДАМ)**
RUN composer install --no-dev --optimize-autoloader -vvv

# 📌 **Енді Laravel командаларын орындауға болады**
RUN php artisan key:generate
RUN php artisan config:cache

# Портты ашу
EXPOSE 8000

# Laravel серверін іске қосу
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
