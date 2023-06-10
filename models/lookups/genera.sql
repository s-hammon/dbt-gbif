with parsed_fields as (
	select
		jsonb_extract_path_text(_airbyte_data, 'genusKey')::int as id,
    	jsonb_extract_path_text(_airbyte_data, 'genus') as name,
		jsonb_extract_path_text(_airbyte_data, 'familyKey')::int as family_id,
		jsonb_extract_path_text(_airbyte_data, 'orderKey')::int as order_id,
		jsonb_extract_path_text(_airbyte_data, 'classKey')::int as class_id,
		jsonb_extract_path_text(_airbyte_data, 'phylumKey')::int as phylum_id,
		jsonb_extract_path_text(_airbyte_data, 'kingdomKey')::int as kingdom_id
	from gbif._airbyte_raw_gbif_genera
)

select
	*
from parsed_fields
where id is not null