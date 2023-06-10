with parsed_fields as (
	select
		jsonb_extract_path_text(_airbyte_data, 'key')::bigint as id,
		jsonb_extract_path_text(_airbyte_data, 'speciesKey')::int as species_id,
		jsonb_extract_path_text(_airbyte_data, 'genusKey')::int as genus_id,
		jsonb_extract_path_text(_airbyte_data, 'familyKey')::int as family_id,
		jsonb_extract_path_text(_airbyte_data, 'orderKey')::int as order_id,
		jsonb_extract_path_text(_airbyte_data, 'classKey')::int as class_id,
		jsonb_extract_path_text(_airbyte_data, 'phylumKey')::int as phylum_id,
		jsonb_extract_path_text(_airbyte_data, 'kingdomKey')::int as kingdom_id,
		jsonb_extract_path_text(_airbyte_data, 'country') as country_of_observation,
		jsonb_extract_path_text(_airbyte_data, 'day')::int as month_day,
		jsonb_extract_path_text(_airbyte_data, 'month')::int as month,
		jsonb_extract_path_text(_airbyte_data, 'year')::int as year,
		jsonb_extract_path_text(_airbyte_data, 'eventDate') as observation_date_string,
		jsonb_extract_path_text(_airbyte_data, 'lastInterpreted')::timestamp AS last_updated,
		jsonb_extract_path_text(_airbyte_data, 'basisOfRecord') as record_type,
		jsonb_extract_path_text(_airbyte_data, 'geodeticDatum') as geodetic_system,
		jsonb_extract_path_text(_airbyte_data, 'decimalLatitude')::float as decimal_lat,
		jsonb_extract_path_text(_airbyte_data, 'decimalLongitude')::float as decimal_lon
	from gbif._airbyte_raw_gbif_observations
)

select
	*
from parsed_fields
where id is not null

	{% if is_incremental() %}

		and last_updated >= (select max(last_updated) from {{ this }})
	{% endif %}