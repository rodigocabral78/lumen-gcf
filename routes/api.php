<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
	// return $router->app->version();
	echo "<pre>{$router->app->version()}</pre>";
	phpinfo();
});

// API route group
$router->group([
	'prefix' => 'api'
], function ($router) {
	// Matches "/api/profile
	$router->get('profile', 'UserController@profile');
	// Matches "/api/users/1
	//get one user by id
	$router->get('users/{id}', 'UserController@singleUser');
	// Matches "/api/users
	$router->get('users', 'UserController@allUsers');
});

$router->group([
	// 'middleware' => 'api',
	'prefix' => 'auth'
], function ($router) {

	$router->post('logout', 'AuthController@logout');
	$router->post('refresh', 'AuthController@refresh');
	$router->post('me', 'AuthController@me');

	// Matches "/auth/register
	$router->post('register', 'AuthController@register');
	// Matches "/auth/login
	$router->post('login', 'AuthController@login');
});
