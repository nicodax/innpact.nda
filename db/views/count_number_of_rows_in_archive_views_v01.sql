with institutions_archive_count as (
	select 'intistutions archive' as archive, data_viewed_at, count(*) as rows_count
	from archive_v_institutions
	group by data_viewed_at
), institution_covenants_archive_count as (
	select 'institution covenants archive' as archive, data_viewed_at, count(*)  as rows_count
	from archive_v_institutions_covenants avic  
	group by data_viewed_at
), loans_archive_count as (
	select 'loans archive' as archive, data_viewed_at, count(*)  as rows_count
	from archive_v_loans avl 
	group by data_viewed_at
), cash_flow_archive_count as (
	select 'cash flow archive' as archive, data_viewed_at, count(*) as rows_count
	from archive_cash_flows acf 
	group by data_viewed_at
), additional_pais_socials_archive_count as (
	select 'additional pais socials archive' as archive, data_viewed_at, count(*) as rows_count
	from archive_v_additional_pai_socials acf 
	group by data_viewed_at
), additional_pais_environments_archive_count as (
	select 'additional pais environments archive' as archive, data_viewed_at, count(*) as rows_count
	from archive_v_additional_pai_environments acf 
	group by data_viewed_at
) select * from (
	select * from institutions_archive_count
	union all
	select * from institution_covenants_archive_count
	union all
	select * from loans_archive_count
	union all
	select * from cash_flow_archive_count
	union all
	select * from additional_pais_socials_archive_count
	union all
	select * from additional_pais_environments_archive_count
) archive;
