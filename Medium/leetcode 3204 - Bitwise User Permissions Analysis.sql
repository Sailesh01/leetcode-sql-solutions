SELECT BIT_AND(permission) AS common_perms,
BIT_OR(permission) AS any_perms
FROM user_permissions