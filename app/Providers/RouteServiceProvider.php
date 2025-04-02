<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Route;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * Маршруттар үшін негізгі жол (namespace).
     *
     * @var string|null
     */
    protected $namespace = 'App\\Http\\Controllers';

    /**
     * Бағдарламаның маршруттарын тіркеу.
     */
    public function boot(): void
    {
        $this->routes(function () {
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/api.php')); // API маршруттарын қосу

            Route::middleware('web')
                ->group(base_path('routes/web.php')); // Веб маршруттарын қосу
        });
    }
}
