WITH 
max_additional_pais_socials_by_reported AS (
    SELECT institution_id, social_pai_reported, MAX(as_of) AS max_as_of
    FROM additional_pais_socials
    WHERE deleted_at IS NULL
    GROUP BY institution_id, social_pai_reported
)
SELECT 
    institutions.id AS institution_id,
    institutions.name AS institution_name,

    /* additional_pais_socials */
    additional_pais_socials.as_of AS pais_social_as_of,
    additional_pais_socials.social_pai_reported,
    additional_pais_socials.social_pai_value,
    GETDATE() As data_viewed_at

FROM institutions
    /* additional_pais_socials */
    JOIN max_additional_pais_socials_by_reported ON max_additional_pais_socials_by_reported.institution_id = institutions.id
    JOIN additional_pais_socials ON additional_pais_socials.institution_id = max_additional_pais_socials_by_reported.institution_id 
    AND additional_pais_socials.social_pai_reported = max_additional_pais_socials_by_reported.social_pai_reported
    AND additional_pais_socials.as_of = max_additional_pais_socials_by_reported.max_as_of
    AND additional_pais_socials.updated_at = (SELECT MAX(updated_at) FROM additional_pais_socials WHERE institution_id = max_additional_pais_socials_by_reported.institution_id AND social_pai_reported = max_additional_pais_socials_by_reported.social_pai_reported)
WHERE 
institutions.deleted_at IS NULL