<?php
require_once __DIR__ . '/model/database.php';

$userId = 'admin';
$password = 'Admin123!';
$firstName = 'Cora';
$lastName = 'Germany';
$email = 'admin@agelesstech.com';
$level = 'Administrator';
$passwordHash = password_hash($password, PASSWORD_DEFAULT);

$sql = "INSERT INTO employees (user_id, password_hash, first_name, last_name, email, employee_level)
        VALUES (?, ?, ?, ?, ?, ?)";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "ssssss", $userId, $passwordHash, $firstName, $lastName, $email, $level);

if (mysqli_stmt_execute($stmt)) {
    echo "Administrator account created.";
} else {
    echo "Administrator may already exist.";
}
?>
