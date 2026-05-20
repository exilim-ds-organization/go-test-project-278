-- name: GetLink :one
SELECT id, original_url, short_name, short_url
FROM links
WHERE id = $1 LIMIT 1;

-- name: ListLinks :many
SELECT id, original_url, short_name, short_url 
FROM links
ORDER BY id
LIMIT $1 OFFSET $2;

-- name: CreateLink :one
INSERT INTO links (
original_url, short_name
) VALUES (
$1, $2 
)
RETURNING id, original_url, short_name, short_url, created_at;

-- name: UpdateLink :exec
UPDATE links
SET original_url = $2, short_name = $3
WHERE id = $1;

-- name: CreateShortName :exec
UPDATE links
SET short_url = $2
WHERE id = $1;

-- name: DeleteLink :exec
DELETE FROM links
WHERE id = $1;

-- name: CounterLinks :one
SELECT COUNT(*) FROM links;

-- name: LastLink :one
SELECT * FROM links
ORDER BY id DESC
LIMIT 1;