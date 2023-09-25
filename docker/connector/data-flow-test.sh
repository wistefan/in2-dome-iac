#!/bin/bash

# Define the URL of the API or endpoint you want to test
SERVICE_PROVIDER_BACKEND_STORAGE_URL="http://localhost:1027/ngsi-ld/v1/entities"
MARKETPLACE_BACKEND_STORAGE_URL="http://localhost:1027/ngsi-ld/v1/entities"


# Define data to send in the request (if needed)
DATA_ID="urn:ngsi-ld:product-offering:1234"
DATA="{\"@type\":\"ProductOffering\",\"category\":\"B2C product orders\",\"channel\":[{\"id\":\"1\",\"name\":\"Online chanel\",\"role\":\"Used channel for order captures\",\"value\":\"Used channel for order capture\"}],\"description\":\"Product Order illustration sample\",\"externalId\":\"PO-456\",\"id\":\"urn:ngsi-ld:product-offering:1234\",\"note\":[{\"author\":\"Jean Pontus\",\"date\":\"2019-04-30T08:13:59.509Z\",\"id\":\"1\",\"text\":\"This is a TMF product order illustration\",\"value\":\"This is a TMF product order illustration\"}],\"priority\":\"1\",\"productOrderItem\":[{\"@type\":\"ProductOrderItem\",\"action\":\"add\",\"id\":\"100\",\"productOffering\":{\"href\":\"https://host:port/productCatalogManagement/v4/productOffering/14277\",\"id\":\"14277\",\"name\":\"TMF25\"},\"productOrderItemRelationship\":[{\"id\":\"110\",\"relationshipType\":\"bundles\"},{\"id\":\"120\",\"relationshipType\":\"bundles\"},{\"id\":\"130\",\"relationshipType\":\"bundles\"}],\"quantity\":1},{\"@type\":\"ProductOrderItem\",\"action\":\"add\",\"id\":\"110\",\"itemPrice\":[{\"description\":\"Access Fee\",\"name\":\"Access Fee\",\"price\":{\"dutyFreeAmount\":{\"unit\":\"EUR\",\"value\":0.99},\"taxIncludedAmount\":{\"unit\":\"EUT\",\"value\":0.99},\"taxRate\":0},\"priceType\":\"nonRecurring\"}],\"payment\":[{\"@referredType\":\"Payment\",\"@type\":\"CashPayment\",\"href\":\"https://host:port/paymentManagement/v4/cashPayment/2365\",\"id\":\"2365\",\"name\":\"Cash payment for access fee\"}],\"product\":{\"@type\":\"Product\",\"isBundle\":false,\"productCharacteristic\":[{\"name\":\"TEL_MSISDN\",\"value\":\"415 279 7439\",\"valueType\":\"string\"}],\"productSpecification\":{\"@type\":\"ProductSpecificationRef\",\"href\":\"https://host:port/productCatalogManagement/v4/productSpecification/14307\",\"id\":\"14307\",\"name\":\"Mobile Telephony\",\"version\":\"1\"}},\"productOffering\":{\"href\":\"https://host:port/productCatalogManagement/v4/productOffering/14305\",\"id\":\"14305\",\"name\":\"TMF Mobile Telephony\"},\"quantity\":1},{\"@type\":\"ProductOrderItem\",\"action\":\"add\",\"billingAccount\":{\"@type\":\"BillingAccount\",\"href\":\"https://host:port/billingAccountManagement/v4/billingAccount/1513\",\"id\":\"1513\"},\"id\":\"120\",\"itemPrice\":[{\"description\":\"Tariff plan monthly fee\",\"name\":\"MonthlyFee\",\"price\":{\"dutyFreeAmount\":{\"unit\":\"EUR\",\"value\":20},\"taxIncludedAmount\":{\"unit\":\"EUR\",\"value\":20},\"taxRate\":0},\"priceAlteration\":[{\"applicationDuration\":3,\"description\":\"20% for first 3 months\",\"name\":\"WelcomeDiscount\",\"price\":{\"@type\":\"price\",\"percentage\":20,\"taxRate\":0},\"priceType\":\"recurring\",\"priority\":1,\"recurringChargePeriod\":\"month\"}],\"priceType\":\"recurring\",\"recurringChargePeriod\":\"month\"}],\"itemTerm\":[{\"description\":\"Tariff plan 12 Months commitment\",\"duration\":{\"amount\":12,\"units\":\"month\"},\"name\":\"12Months\"}],\"product\":{\"@type\":\"Product\",\"isBundle\":false,\"productSpecification\":{\"@type\":\"ProductSpecificationRef\",\"href\":\"https://host:port/productCatalogManagement/v4/productSpecification/14395\",\"id\":\"14395\",\"name\":\"TMF Tariff plan\",\"version\":\"1\"}},\"productOffering\":{\"href\":\"https://host:port/productCatalogManagement/v4/productOffering/14344\",\"id\":\"14344\",\"name\":\"TMF Tariff Plan\"},\"productOrderItemRelationship\":[{\"id\":\"110\",\"relationshipType\":\"reliesOn\"}],\"quantity\":1},{\"@type\":\"ProductOrderItem\",\"action\":\"add\",\"id\":\"130\",\"product\":{\"@type\":\"Product\",\"isBundle\":false,\"productCharacteristic\":[{\"name\":\"CoverageOptions\",\"value\":\"National\",\"valueType\":\"string\"}],\"productSpecification\":{\"@type\":\"ProductSpecificationRef\",\"href\":\"https://host:port/productCatalogManagement/v4/productSpecification/14353\",\"id\":\"14353\",\"name\":\"Coverage\",\"version\":\"1\"}},\"productOffering\":{\"href\":\"https://host:port/productCatalogManagement/v4/productOffering/14354\",\"id\":\"14354\",\"name\":\"Coverage Options\"},\"productOrderItemRelationship\":[{\"id\":\"110\",\"relationshipType\":\"reliesOn\"}],\"quantity\":1}],\"relatedParty\":[{\"@referredType\":\"Individual\",\"@type\":\"RelatedParty\",\"href\":\"https://host:port/partyManagement/v4/individual/456-dd-df45\",\"id\":\"456-dd-df45\",\"name\":\"Joe Doe\",\"role\":\"Seller\"},{\"@referredType\":\"Customer\",\"@type\":\"RelatedParty\",\"href\":\"https://host:port/partyRoleManagement/v4/customer/ff55-hjy4\",\"id\":\"ff55-hjy4\",\"name\":\"Jean Pontus\"}],\"requestedCompletionDate\":\"2019-05-02T08:13:59.506Z\",\"requestedStartDate\":\"2019-05-03T08:13:59.506Z\"}"

# Send a POST request with data
RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "$DATA" "$SERVICE_PROVIDER_BACKEND_STORAGE_URL")

# Check if the response is empty
if [ -z "$RESPONSE" ]; then
    echo "Error: Empty response"
    exit 1
fi

# Check if the response contains a specific string
if [[ "$RESPONSE" == *"expected_string"* ]]; then
    echo "Response contains expected content"
else
    echo "Response does not contain expected content"
    exit 1
fi

## Check if Service Provider Backend Storage stores the data
# Send a GET request
RESPONSE=$(curl -s -X GET "$SERVICE_PROVIDER_BACKEND_STORAGE_URL/$DATA_ID")

# Check if the response is empty
if [ -z "$RESPONSE" ]; then
    echo "Error: Empty response"
    exit 1
fi

