
all : data/raw/provincial_voter_participation_by_age_group.csv data/raw/provincial_voting_results.csv

# download data
data/raw/provincial_voter_participation_by_age_group.csv data/raw/provincial_voting_results.csv : src/download_data.R
	Rscript src/download_data.R https://catalogue.data.gov.bc.ca/dataset/44914a35-de9a-4830-ac48-870001ef8935/resource/fb40239e-b718-4a79-b18f-7a62139d9792/download/provincial_voting_results.csv https://catalogue.data.gov.bc.ca/dataset/6d9db663-8c30-43ec-922b-d541d22e634f/resource/646530d4-078c-4815-8452-c75639962bb4/download/provincial_voter_participation_by_age_group.csv --path=data/raw

# cleaning