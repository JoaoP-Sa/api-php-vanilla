<?php
declare(strict_types=1);

spl_autoload_register(function($class) {
    require __DIR__."/src/$class.php";
});

header('Content-type: application/json; charset: UTF-8;');

set_error_handler("ErrorHandler::handleError");
set_exception_handler("ErrorHandler::handleException");

$parts = explode("/", $_SERVER["REQUEST_URI"]);

if ($parts[1] != "products") {
    http_response_code(404);
    exit;
}

$id = $parts[2] ?? null;

$database = new Database("db", "product_db", "root", "root");

$gateway = new ProductGateway($database);

$productController = new ProductController($gateway);

$productController->processRequest($_SERVER["REQUEST_METHOD"], $id);