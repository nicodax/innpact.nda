WITH 
max_additional_pais_environments_by_as_of AS (
    SELECT institution_id, environment_pai_reported, MAX(as_of) AS max_as_of
    FROM additional_pais_environments
    WHERE deleted_at IS NULL
    GROUP BY institution_id, environment_pai_reported
),
max_additional_pais_environments_by_updated_at AS (
    SELECT additional_pais_environments.institution_id, additional_pais_environments.environment_pai_reported, updated_at AS max_updated_at, as_of, environment_pai_value
    FROM additional_pais_environments
		JOIN max_additional_pais_environments_by_as_of ON max_additional_pais_environments_by_as_of.max_as_of = additional_pais_environments.as_of 
		AND max_additional_pais_environments_by_as_of.institution_id = additional_pais_environments.institution_id
		AND max_additional_pais_environments_by_as_of.environment_pai_reported = additional_pais_environments.environment_pai_reported
    WHERE deleted_at IS NULL 
),
filtered_additional_pais_environments AS(
	SELECT max_additional_pais_environments_by_updated_at.institution_id, max_additional_pais_environments_by_updated_at.environment_pai_reported, max_additional_pais_environments_by_updated_at.as_of, MAX(max_additional_pais_environments_by_updated_at.max_updated_at) AS max_updated_at
	FROM max_additional_pais_environments_by_updated_at
	GROUP BY max_additional_pais_environments_by_updated_at.institution_id, max_additional_pais_environments_by_updated_at.environment_pai_reported, max_additional_pais_environments_by_updated_at.as_of
)

SELECT 
	institutions.id AS institution_id,
    institutions.name AS institution_name,

    /* additional_pais_environments */
    additional_pais_environments.as_of AS pais_environment_as_of,
    additional_pais_environments.environment_pai_reported,
    additional_pais_environments.environment_pai_value,
    GETDATE() As data_viewed_at
FROM filtered_additional_pais_environments
	JOIN additional_pais_environments ON additional_pais_environments.as_of = filtered_additional_pais_environments.as_of
	AND additional_pais_environments.updated_at = filtered_additional_pais_environments.max_updated_at
	AND additional_pais_environments.environment_pai_reported = filtered_additional_pais_environments.environment_pai_reported
	AND additional_pais_environments.institution_id = filtered_additional_pais_environments.institution_id
	JOIN institutions ON institutions.id = filtered_additional_pais_environments.institution_id
WHERE 
institutions.deleted_at IS NULL