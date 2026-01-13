-- Créer un utilisateur "demo_user" avec mot de passe
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'demo_user') THEN
    CREATE USER demo_user WITH PASSWORD 'demo_pass';
  END IF;
END
$$;

-- Donner tous les privilèges à l'utilisateur "demo_user" sur la base de données hyban_demo_db
GRANT ALL PRIVILEGES ON DATABASE hyban_demo_db TO demo_user;

-- Définir l'utilisateur "demo_user" comme propriétaire de la base
ALTER DATABASE hyban_demo_db OWNER TO demo_user;

-- Autoriser l'utilisateur "demo_user" à être SUPERUSER (optionnel, utile pour tests demo)
ALTER ROLE demo_user SUPERUSER;

-- Assurer que l'utilisateur "postgres" est SUPERUSER et a accès à tout
ALTER ROLE postgres SUPERUSER;

-- Remarque : modification de pg_hba.conf via SQL n'est pas possible directement
-- Pour autoriser les connexions distantes, tu dois modifier pg_hba.conf ou utiliser Docker networking
-- Exemple : dans Docker, le container app se connecte via le réseau interne Docker, donc pas besoin de modification
