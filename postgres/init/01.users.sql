CREATE TABLE IF NOT EXISTS public.users (
    id SERIAL PRIMARY KEY,
    name varchar (50) NOT NULL,
    email varchar (50) UNIQUE NOT NULL,
    role varchar (50) NOT NULL,
    password varchar (200) NOT NULL,
    public_id varchar (100) UNIQUE NOT NULL,
    image TEXT,
    created_on TIMESTAMP,
    last_login TIMESTAMP,
    verified BOOLEAN NOT NULL,
    approved BOOLEAN NOT NULL,
    enabled BOOLEAN NOT NULL,
    reset_token varchar (50),
    reset_expr TIMESTAMP,
    verify_token varchar (50) UNIQUE,
    verify_expr TIMESTAMP,
    api_key varchar (50) UNIQUE
);
