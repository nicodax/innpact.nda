WITH 
max_additional_pais_environments_by_reported AS (
    SELECT institution_id, environment_pai_reported, MAX(as_of) AS max_as_of
    FROM additional_pais_environments
    WHERE deleted_at IS NULL
    GROUP BY institution_id, environment_pai_reported
)
SELECT 
    institutions.id AS institution_id,
    institutions.name AS institution_name,

    /* additional_pais_environments */
    additional_pais_environments.as_of AS pais_environment_as_of,
    additional_pais_environments.environment_pai_reported,
    additional_pais_environments.environment_pai_value,
    GETDATE() As data_viewed_at

FROM institutions
    /* additional_pais_environments */
    JOIN max_additional_pais_environments_by_reported ON max_additional_pais_environments_by_reported.institution_id = institutions.id
    JOIN additional_pais_environments ON additional_pais_environments.institution_id = max_additional_pais_environments_by_reported.institution_id 
    AND additional_pais_environments.environment_pai_reported = max_additional_pais_environments_by_reported.environment_pai_reported
    AND additional_pais_environments.as_of = max_additional_pais_environments_by_reported.max_as_of
	AND additional_pais_environments.updated_at = (SELECT MAX(updated_at) FROM additional_pais_environments WHERE institution_id = max_additional_pais_environments_by_reported.institution_id AND environment_pai_reported = max_additional_pais_environments_by_reported.environment_pai_reported)
WHERE 
institutions.deleted_at IS NULL