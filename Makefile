export
AWS_PROFILE=snowball
dev_S3_BUCKET=dev-app.axial.exchange
staging_S3_BUCKET=dev-stg.axial.exchange
prod_S3_BUCKET=dev-app.axial.exchange
dev_DISTRIBUTION_ID=E1896O31DT0GF5
staging_DISTRIBUTION_ID=
prod_DISTRIBUTION_ID=

test-envvars:
	@[ "${env}" ] || ( echo "env var is not set"; exit 1 )

build: test-envvars
	npm run build

all: build
	aws s3 cp --recursive build/ s3://${${env}_S3_BUCKET} && aws cloudfront create-invalidation \
	--distribution-id ${${env}_DISTRIBUTION_ID} \
	--paths "/*"
