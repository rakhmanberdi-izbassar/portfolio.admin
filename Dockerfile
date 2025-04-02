# PHP 8.0 CLI бейнесін негіз ретінде алыңыз
FROM php:8.0-cli

# Composer-ды орнатыңыз
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Жұмыс каталогын анықтаңыз
WORKDIR /app

# Қосымшаңызды көшіріңіз
COPY . .

# Composer тәуелділіктерін орнатыңыз
RUN composer install --no-dev --optimize-autoloader

# Портты ашыңыз (Laravel үшін әдетте 8000 порт)
EXPOSE 8000

# Laravel серверін іске қосыңыз
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
