-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS links (
	id BIGSERIAL PRIMARY KEY,
	original_url TEXT,
	short_name TEXT UNIQUE,
	short_url TEXT,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS links;
-- +goose StatementEnd