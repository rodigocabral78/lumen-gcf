#!/usr/bin/php -f
<?php

$user = "root:t00r";
echo "$user\n";
echo "\nDate -> " . date('Y-m-d H:i:s');
echo "\nt00r -> " .password_hash("t00r", PASSWORD_DEFAULT);
echo "\n123456 -> " .password_hash("123456", PASSWORD_DEFAULT);
echo "\n123456 -> " .password_hash("n123456", PASSWORD_BCRYPT, ['cost' => 12]);
echo "\n";
