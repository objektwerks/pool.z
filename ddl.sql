DROP SCHEMA PUBLIC CASCADE;
CREATE SCHEMA PUBLIC;

CREATE TABLE account (
  id BIGSERIAL PRIMARY KEY,
  license VARCHAR(36) UNIQUE NOT NULL,
  email_address VARCHAR NOT NULL,
  pin VARCHAR(7) NOT NULL,
  activated BIGINT NOT NULL,
  deactivated BIGINT NOT NULL
);

CREATE TABLE pool (
  id BIGSERIAL PRIMARY KEY,
  license VARCHAR(36) REFERENCES account(license),
  name VARCHAR(24) NOT NULL,
  built INT NOT NULL,
  volume INT NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE surface (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  installed BIGINT NOT NULL,
  kind VARCHAR NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE deck (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  installed BIGINT NOT NULL,
  kind VARCHAR NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE pump (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  installed BIGINT NOT NULL,
  model VARCHAR NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE timer (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  installed BIGINT NOT NULL,
  model VARCHAR NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE timer_setting (
  id BIGSERIAL PRIMARY KEY,
  timer_id BIGINT REFERENCES timer(id),
  created BIGINT NOT NULL,
  time_on SMALLINT NOT NULL,
  time_off SMALLINT NOT NULL
);

CREATE TABLE heater (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  installed BIGINT NOT NULL,
  model VARCHAR NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE heater_setting (
  id BIGSERIAL PRIMARY KEY,
  heater_id BIGINT REFERENCES heater(id),
  temp INT NOT NULL,
  date_on BIGINT NOT NULL,
  date_off BIGINT NOT NULL
);

CREATE TABLE measurement (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  measured BIGINT NOT NULL,
  temp INT NOT NULL,
  total_hardness INT NOT NULL,
  total_chlorine INT NOT NULL,
  total_bromine INT NOT NULL,
  free_chlorine INT NOT NULL,
  ph NUMERIC(2, 1) NOT NULL,
  total_alkalinity INT NOT NULL,
  cyanuric_acid INT NOT NULL
);

CREATE TABLE cleaning (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  cleaned BIGINT NOT NULL,
  brush BOOL NOT NULL,
  net BOOL NOT NULL,
  vacuum BOOL NOT NULL,
  skimmer_basket BOOL NOT NULL,
  pump_basket BOOL NOT NULL,
  pump_filter BOOL NOT NULL,
  deck BOOL NOT NULL
);

CREATE TABLE chemical (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  added BIGINT NOT NULL,
  chemical VARCHAR NOT NULL,
  amount NUMERIC(5, 2),
  unit VARCHAR NOT NULL
);

CREATE TABLE supply (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  purchased BIGINT NOT NULL,
  item VARCHAR NOT NULL,
  amount NUMERIC(4, 2) NOT NULL,
  unit VARCHAR NOT NULL,
  cost Int NOT NULL
);

CREATE TABLE repair (
  id BIGSERIAL PRIMARY KEY,
  pool_id BIGINT REFERENCES pool(id),
  repaired BIGINT NOT NULL,
  repair VARCHAR NOT NULL,
  cost INT NOT NULL
);

CREATE TABLE email (
  id VARCHAR PRIMARY KEY,
  license VARCHAR(36) REFERENCES account(license),
  address VARCHAR NOT NULL,
  date_sent BIGINT NOT NULL,
  time_sent BIGINT NOT NULL,
  processed BOOL NOT NULL,
  valid BOOL NOT NULL
);

CREATE TABLE fault (
  date_of BIGINT NOT NULL,
  time_of BIGINT NOT NULL,
  nano_of BIGINT NOT NULL,
  cause VARCHAR NOT NULL,
  PRIMARY KEY (date_of, time_of, nano_of)
);